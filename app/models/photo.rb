# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  position   :integer
#  created_at :datetime
#  taken_at   :datetime
#

class Photo < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :albums
  acts_as_list

  # Dimensions of image sizes
  LARGE_HEIGHT = 650
  LARGE_WIDTH = 488
  MEDIUM_HEIGHT = 300
  MEDIUM_WIDTH = 225
  THUMB_HEIGHT = 100
  THUMB_WIDTH = 100

  UPLOAD_FOLDER = RAILS_ROOT + '/public/photos/'
  WEB_FOLDER = '/photos/'
  def to_url(size = :medium)
    return WEB_FOLDER + "#{id}_#{size.to_s}.jpg" if [:large, :medium, :thumbnail].include?(size)
    raise 'Bad size'
  end

  # write takes a file from a form and writes all our sizes to disk
  def write(file)
    raise "No file uploaded" if file.nil?
    file = file.read
    [:original, :large, :medium, :thumbnail].each do |size|
      logger.info "Generating #{size} image. file type: #{file.class}"
      resize(size, file).write(UPLOAD_FOLDER + "#{id}_#{size}.jpg")
      logger.info "#{size.to_s} image written to disk: " + UPLOAD_FOLDER + "#{id}_#{size}.jpg"
    end
  end

  def rm
    logger.info "Removing #{id}_*.jpg from disk."
    FileUtils.rm Dir.glob(UPLOAD_FOLDER + "#{id}_*.jpg")
  end

  private

  # resize takes a size and a blob image and sizes it accordingly
  def resize(size = :medium, file = nil)
    image = Magick::Image.from_blob(file).first
    case size
    when :original
      return image
    when :large
      geometry = "#{LARGE_WIDTH}x#{LARGE_HEIGHT}"
    when :medium
      geometry = "#{MEDIUM_WIDTH}x#{MEDIUM_HEIGHT}"
    when :thumbnail
      geometry = "#{THUMB_WIDTH}x#{THUMB_HEIGHT}"
      return crop_part(image, geometry)
    else
      raise 'No size recognized'
    end
    image.change_geometry!(geometry) do |cols,rows,img|
      img.resize!(cols,rows)
    end
  end

  def crop_part(image, size)
    target_w = size.split(/x/)[0].to_i
    target_h = size.split(/x/)[1].to_i
    orig_w = image.columns
    orig_h = image.rows

    if (orig_w.to_f/orig_h) > (target_w.to_f/target_h)
      image.change_geometry!("x"+target_h.to_s) { |cols, rows, img| img.resize!(cols, rows) }
      image.crop!((image.columns - target_w) / 2, 0, target_w, target_h)
    else
      image.change_geometry!(target_w.to_s+"x") { |cols, rows, img| img.resize!(cols, rows) }
      image.crop!(0, (image.rows - target_h) / 2, target_w, target_h)
    end
  end

  def before_destroy
    rm
  end

end

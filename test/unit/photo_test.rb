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

require File.join(File.dirname(__FILE__), *%w[.. test_helper])

class PhotoTest < ActiveSupport::TestCase
  fixtures :photos

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Photo, photos(:first)
  end
end

require "digest/sha1"
class User < ActiveRecord::Base

  has_many :photos
  has_many :albums

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_uniqueness_of   :login, :email, :salt
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_presence_of     :login, :email, :first_name, :last_name
  validates_presence_of     :password,
                            :password_confirmation,
                            :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  before_save :encrypt_password
  # Uncomment this to use activation
  # before_create :make_activation_code

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    # use this instead if you want user activation
    # u = find :first, :select => 'id, salt', :conditions => ['login = ? and activated_at IS NOT NULL', login]
    u = find_by_login(login) # need to get the salt
    return nil unless u
    find :first, :conditions => ["id = ? AND crypted_password = ?", u.id, u.encrypt(password)]
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def is_admin?
    false
  end


  protected

  # before filter
  def encrypt_password
    return unless password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.nil? or not password.blank?
  end

end

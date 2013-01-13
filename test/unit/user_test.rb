# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  login            :string(255)
#  email            :string(255)
#  crypted_password :string(255)
#  salt             :string(255)
#  activation_code  :string(255)
#  activated_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  first_name       :string(255)
#  last_name        :string(255)
#

require File.join(File.dirname(__FILE__), *%w[.. test_helper])

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_should_create_user
    assert create_user.valid?
  end

  def test_should_require_login
    u = create_user(:login => nil)
    assert u.errors.on(:login)
  end

  def test_should_require_password
    u = create_user(:password => nil)
    assert u.errors.on(:password)
  end

  def test_should_require_password_confirmation
    u = create_user(:password_confirmation => nil)
    assert u.errors.on(:password_confirmation)
  end

  def test_should_require_email
    u = create_user(:email => nil)
    assert u.errors.on(:email)
  end

  def test_should_reset_password
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attribute(:login, 'quentin2')
    assert_equal users(:quentin), User.authenticate('quentin2', 'quentin')
  end

  def test_should_authenticate_user
    assert_equal users(:quentin), User.authenticate('quentin', 'quentin')
  end

  protected
  def create_user(options = {})
    User.create({
      :first_name => "Quire", :last_name => "Mucho",
      :login => 'quire', :email => 'quire@example.com',
      :password => 'quire', :password_confirmation => 'quire'
    }.merge(options))
  end
end

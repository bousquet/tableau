require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  include AuthenticatedTestHelper

  fixtures :users

  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    
    # for testing action mailer
    # @emails = ActionMailer::Base.deliveries 
    # @emails.clear
  end

  def test_should_login_and_redirect
    post :login, :login => 'quentin', :password => 'quentin'
    assert session[:user]
    assert_response :redirect
  end

  def test_should_fail_login_and_not_redirect
    post :login, :login => 'quentin', :password => 'bad password'
    assert_nil session[:user]
    assert_response :success
  end

  def test_should_allow_signup
    old_count = User.count
    create_user
    assert_response :redirect
    assert_equal old_count+1, User.count
  end

  def test_should_require_login_on_signup
    old_count = User.count
    create_user(:login => nil)
    assert assigns(:user).errors.on(:login)
    assert_response :success
    assert_equal old_count, User.count
  end

  def test_should_require_password_on_signup
    old_count = User.count
    create_user(:password => nil)
    assert assigns(:user).errors.on(:password)
    assert_response :success
    assert_equal old_count, User.count
  end

  def test_should_require_password_confirmation_on_signup
    old_count = User.count
    create_user(:password_confirmation => nil)
    assert assigns(:user).errors.on(:password_confirmation)
    assert_response :success
    assert_equal old_count, User.count
  end

  def test_should_require_email_on_signup
    old_count = User.count
    create_user(:email => nil)
    assert assigns(:user).errors.on(:email)
    assert_response :success
    assert_equal old_count, User.count
  end

  def test_should_logout
    login_as :quentin
    get :logout
    assert_nil session[:user]
    assert_response :redirect
  end

  # Uncomment if you're activating new user accounts
  # 
  # def test_should_activate_user
  #   assert_nil User.authenticate('arthur', 'arthur')
  #   get :activate, :id => users(:arthur).activation_code
  #   assert_equal users(:arthur), User.authenticate('arthur', 'arthur')
  # end
  # 
  # def test_should_activate_user_and_send_activation_email
  #   get :activate, :id => users(:arthur).activation_code
  #   assert_equal 1, @emails.length
  #   assert(@emails.first.subject =~ /Your account has been activated/)
  #   assert(@emails.first.body    =~ /#{assigns(:user).login}, your account has been activated/)
  # end
  # 
  # def test_should_send_activation_email_after_signup
  #   create_user
  #   assert_equal 1, @emails.length
  #   assert(@emails.first.subject =~ /Please activate your new account/)
  #   assert(@emails.first.body    =~ /Username: quire/)
  #   assert(@emails.first.body    =~ /Password: quire/)
  #   assert(@emails.first.body    =~ /account\/activate\/#{assigns(:user).activation_code}/)
  # end

  protected
  def create_user(options = {})
    post :signup, :user => { :login => 'quire', :email => 'quire@example.com', 
                             :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end

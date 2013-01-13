class AccountController < ApplicationController
  skip_before_filter :login_required, :only => [:index, :login]

  # say something nice, you goof!  something sweet.
  def index
    login
    render :action=>"login"
  end

  def login
    redirect_to(:action => 'signup') and return unless User.count > 0
    return unless request.post?
    @user = User.new(params[:user])
    self.current_user = User.authenticate(@user.login, @user.password)
    if current_user
      redirect_back_or_default(:controller => 'gallery', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      flash.now[:error] = "Incorrect Login/Password"
    end
  end

  def signup
    redirect_to(:action=>"login") and return unless logged_in? or User.count < 1
    @user = User.new(params[:user])
    return unless request.post?
    if @user.save
      redirect_back_or_default(:controller => 'gallery', :action => 'index')
      flash[:notice] = "Thanks for signing up!"
    end
  end

  def logout
    self.current_user = nil
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => 'gallery', :action => 'index')
  end
end

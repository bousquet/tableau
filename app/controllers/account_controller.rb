class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # To require logins, use:
  #
  #   before_filter :login_required                            # restrict all actions
  #   before_filter :login_required, :only => [:edit, :update] # only restrict these actions
  # 
  # To skip this in a subclassed controller:
  #
  #   skip_before_filter :login_required

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
  
  # Sample method for activating the current user
  #def activate
  #  @user = User.find_by_activation_code(params[:id])
  #  if @user and @user.activate
  #    self.current_user = @user
  #    redirect_back_or_default(:controller => '/account', :action => 'index')
  #    flash[:notice] = "Your account has been activated."
  #  end
  #end

  def logout
    self.current_user = nil
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => 'gallery', :action => 'index')
  end
end

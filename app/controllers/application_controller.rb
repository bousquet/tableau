# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  before_filter :load_curuser
  
  
  protected
  
  def load_curuser
    if session[:user]
      @curuser = User.find(session[:user])
    end
  end
end
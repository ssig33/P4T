# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  def login_check
    if @login_user = User.find_by_id(session[:login_id])
      return @login_user
    else
      redirect_to :controller => :session
    end
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

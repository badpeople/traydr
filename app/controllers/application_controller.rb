# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  def admin_authed
    ret = !current_user.nil? && current_user.admin?
    logger.debug "here is the bool " + ret.to_s
    if !ret
      redirect_to :status=>404
    end
  end

  include Authentication
  include Traydr
  include TraydrLogging
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_timezone

  def root_url
    "/"
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def set_timezone
    @time = Time.zone = "Eastern Time (US & Canada)"
  end
end

class AdminController < ApplicationController
  before_filter :admin_authed, :only=>[:console]

  def test_email_load

  end

  def index

  end

  def console
    @systems = System.all
    @users = User.all
    

  end

  def admin_authed
    ret = !current_user.nil? && current_user.admin?
    logger.debug "here is the bool " + ret.to_s
    if !ret
      redirect_to :status=>404
    end
  end
end

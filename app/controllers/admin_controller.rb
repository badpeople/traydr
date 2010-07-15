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

  
end

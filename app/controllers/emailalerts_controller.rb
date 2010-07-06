class EmailalertsController < ApplicationController

  before_filter :own_system, :only=>[:new,:create]

  def index
    @emailalerts = Emailalert.all
  end
  
  def show
    @emailalert = Emailalert.find(params[:id])
    
  end
  
  def new
    @emailalert = Emailalert.new
    system_id = params[:system_id] 
    if system_id.nil?
      raise "system_id param cannot be empty"
    end
    @system = System.find(:first, system_id)
  end
  
  def create
    @emailalert = Emailalert.new(params[:emailalert])
    @emailalert.system = System.find(params[:emailalert][:system_id])
    @emailalert.send_at = DateTime.now
    if @emailalert.save
      flash[:notice] = "Successfully created email alert."
      redirect_to @emailalert
      emailalert = @emailalert
      subscriptions = Subscription.find_all_by_system_id(emailalert.system_id)
      system = emailalert.system
      for subscription in subscriptions
        email_package = {:email=>subscription.user.email,
          :username=>subscription.user.email,
          :subscription_id=>subscription.id,
          :system_username=>system.user.username,
          :system_id=>system.id,
          :system_name=>system.name
        }
        MailingsWorker.async_send_mailing(:email_package=>email_package,:title=>emailalert.title,:body=>emailalert.body)
      end
    
    else
      render :action => 'new'
    end
  end
  
  def edit
    @emailalert = Emailalert.find(params[:id])
  end
  
  def update
    @emailalert = Emailalert.find(params[:id])
    if @emailalert.update_attributes(params[:emailalert])
      flash[:notice] = "Successfully updated emailalert."
      redirect_to @emailalert
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @emailalert = Emailalert.find(params[:id])
    @emailalert.destroy
    flash[:notice] = "Successfully destroyed emailalert."
    redirect_to emailalerts_url
  end

  def setup_emails(email_packages, title, body, mailer)
    for email_package in email_packages
      logger.debug "sending email for subscription=#{email_package[:email]}"
      mailer.deliver_email(email_package, title, body)
    end
  end

  private
  def own_system

    if logged_in?
      system_id = params[:system_id] || params[:emailalert][:system_id]
      system = System.find(system_id)
      if system.user.id == current_user.id
        return true
      end
    end
    flash[:error] = "Sorry, you don't have permission to do that."
    store_target_location
    redirect_to login_url
  end

end

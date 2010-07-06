require 'net/http'


class SubscriptionsController < ApplicationController
  before_filter :login_required, :only=>[:new,:create]
  before_filter :own_or_admin, :only=>[:show,:edit,:update,:destroy]
  protect_from_forgery :only=>[:update,:create]
  def index
    if logged_in? then
      @subscriptions = Subscription.find_all_by_user_id(current_user.id)
    else
      redirect_to :controller=>'systems'
    end
  end
  
  def show
    @subscription = Subscription.find(params[:id])
  end
  
  def new
    if current_user_confirmed?
      system_id = params[:system]

      @system = System.find(system_id)

      if @system.price_email > 0 then
        @user = current_user
        @subscription = Subscription.new
        @subscription.status = "NEW"
        # check to see if this user already has a subscription to this system
        already_subscribed = Subscription.find(:first, :conditions=>"system_id = #{system_id} AND user_id = #{current_user.id}")
        if !already_subscribed.nil?
          redirect_to :action=>"edit", :id=>already_subscribed.id
        end
      else
        @subscription = Subscription.new(params[:subscription])
        @subscription.status = "CONFIRMED"
        @subscription.user = current_user
        @subscription.to_email = current_user.email
        @subscription.system = @system
        if @subscription.save
          flash[:notice] = "Successfully created subscription.  Remember, add \"alert@traydr.com\" to your email contacts.  As this will be the email that you receive alerts from."
          MailingsWorker.async_send_subscription_confirmation(:email=>@subscription.system.user.email,
                                                              :system_name => @subscription.system.name,
                                                              :system_id=>@system.id,
                                                              :user_id=>current_user.id)          
          redirect_to @system
        else
          render :action => 'new'
        end
      end
    else
      flash[:error] = "You must confirm your email before subscribing to a system.  If you can't find your confirmation email, <a href=\"/resend\">click here</a> to get it resent."
      redirect_to :back
    end

  end
  
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.status = "CONFIRMED"
    @subscription.system_id = nil
    @subscription.user = current_user
    @subscription.to_email = current_user.email
    @subscription.system = System.find(params[:subscription][:system_id])
    if @subscription.save
      flash[:notice] = "Successfully created subscription."
      redirect_to @subscription
    else
      render :action => 'new'
    end
  end
  
  def edit
    @subscription = Subscription.find(params[:id])
    @system = @subscription.system
    @user = current_user
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update_attributes(params[:subscription])
      flash[:notice] = "Successfully updated subscription."
      redirect_to @subscription
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    flash[:notice] = "Successfully destroyed subscription."
    redirect_to subscriptions_url
  end

  def get_model
    return Subscription
  end


  def order_completed
    logger.info "from paypal:\n"
    logger.info params.to_yaml
    post_text = request.raw_post
    logger.debug "raw post "
    logger.debug post_text

    notify = Paypal::Notification.new(request.raw_post)

    if notify.acknowledge
      logger.info "PayPal acknowledged"
      # parse out the system, and the user, update the settings
      @system = System.find(params[:invoice])
      @user = User.find(params[:custom])
      subscriptions = Subscription.find_by_sql(find_users_subscription(@user.id, @system.id))
      if !subscriptions.nil? && subscriptions.size() == 1 then
        @subscription = subscriptions[0]
        @subscription.update_attributes(:status=>status_confirmed,:paypal_payer_email=>params[:payer_email],:paypal_subscr_id=>params[:subscr_id], :paypal_payer_id=>params[:payer_id])

        begin
          MailingsWorker.async_send_subscription_confirmation(:email=>@subscription.system.user.email,
                                                              :system_name => @subscription.system.name,
                                                              :system_id=>@system.id,
                                                              :user_id=>@user.id)
        rescue => e
          logger.error "error generating subscription confirmed email via paypal callback"
          logger.error e.inspect
          logger.error e.backtrace
        end
      elsif !subscriptions.nil? && subscriptions.size() > 1
        logger.error "more than one subscription was found for where system id = #{@system.id} and user id = #{@user.id}"
      else
        logger.error "paypal callback: could not find subscription where system id = #{@system.id} and user id = #{@user.id}"
      end
      
    else
      logger.debug "PayPal NOT acknowledged"
    end

    render :nothing => true
  end

  def order_done
    flash[:notice] = "Order completed and confirmed"
     redirect_to :action => "index"
  end

  def ajax_create
    # check to see if we haven't already created one
    already_present = Subscription.find_by_sql(find_users_subscription(current_user.id,params[:system_id]))
    if !already_present.nil? && already_present.size() > 0
      logger.warn "Already found a subscription for user=#{current_user.id} and system=#{params[:system_id]}"
      render :text=>"SUCCESS"
      return
    end
    @subscription = Subscription.new(params[:subscription])
    @subscription.status = current_user.admin? ? "CONFIRMED" : "UNCONFIRMED"
    @subscription.system_id = nil
    @subscription.user = current_user
    @subscription.to_email = current_user.email
    @subscription.system = System.find(params[:system_id])
    if @subscription.save then
      render :text=>"SUCCESS"
    else
      render :text=>"FAILURE"
    end


  end
end

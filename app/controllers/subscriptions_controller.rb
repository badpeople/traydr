class SubscriptionsController < ApplicationController
  before_filter :login_required, :only=>[:new,:create]
  before_filter :own_or_admin, :only=>[:show,:edit,:update,:destroy]
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
    @subscription = Subscription.new
    system_id = params[:system]
    # check to see if this user already has a subscription to this system
    already_subscribed = Subscription.find(:first,:conditions=>"system_id = #{system_id} AND user_id = #{current_user.id}")
    if !already_subscribed.nil?
      redirect_to :action=>"edit",:id=>already_subscribed.id
    end
    @system = System.find(system_id)

  end
  
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.status = "CONFIRMED"
    @subscription.system_id = nil
    @subscription.user = current_user
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
end

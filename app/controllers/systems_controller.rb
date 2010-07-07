class SystemsController < ApplicationController
  before_filter :login_required, :only=>[:new,:create,:mine]
  before_filter :own_or_admin, :only=>[:edit,:update,:destroy,:administer]

  def index
    @keywords = default_keywords
    @description = default_description

    page = params[:page] || 1
    if params[:filter] == "price-low-high"
      @systems = System.paginate(:all,:order=>"price_email",:page=>page)
    elsif params[:filter] == "price-high-low"
      @systems = System.paginate(:all,:order=>"price_email DESC",:page=>page)
    elsif params[:filter] == "only-free"
      @systems = System.paginate(:all,:conditions=>{:price_email=>0},:page=>page)
    elsif params[:filter] == "newest"
      @systems = System.paginate(:all,:order=>"created_at DESC",:page=>page)
    elsif params[:filter] == "oldest"
      @systems = System.paginate(:all,:order=>:created_at,:page=>page)
    elsif params[:filter] == "most-subscribers"

        systems_by_subs = System.all
        systems_by_subs.sort! { |a, b|
          b.subscription_count() <=> a.subscription_count()
        }
      @systems = systems_by_subs.paginate(:page=> page, :per_page=>System.per_page )
    else params[:filter] == "highest-rated"
        systems_by_rating = System.all
        systems_by_rating.sort! { |a, b|
          b.average_rating() <=> a.average_rating()
        }
      @systems = systems_by_rating.paginate(:page=> page, :per_page=>System.per_page )

    end

  end
  
  def show
    @system = System.find(params[:id])
    @content_for_title = @system.name
    @keywords = default_keywords + @system.name
    @reviews = Review.find_all_by_system_id(@system.id)
    @description = default_description + @system.description 

    if logged_in?
      results = Subscription.find_by_sql(find_users_subscription(current_user.id,params[:id]))
       if !results.nil? && results.size() > 0
         @subscription = results[0]
       end
    end
  end
  
  def new
    @system = System.new
  end
  
  def create
    @system = System.new(params[:system])
    @system.user = current_user
    @system.price_sms = 0
    if @system.save
      flash[:notice] = "Successfully created system."
      redirect_to @system
    else
      render :action => 'new'
    end
  end
  
  def edit
    @system = System.find(params[:id])
  end
  
  def update
    @system = System.find(params[:id])
    if @system.update_attributes(params[:system])
      flash[:notice] = "Successfully updated system."
      redirect_to @system
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @system = System.find(params[:id])
    @system.destroy
    flash[:notice] = "Successfully destroyed system."
    redirect_to systems_url
  end

  def get_model
    return System
  end

  def mine
    @systems = System.find_by_user(current_user)
  end

  def administer
    @system = System.find(params[:id])
  end
end

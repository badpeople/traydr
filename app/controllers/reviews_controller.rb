class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find(params[:id])
    @current_user = current_user
  end
  
  def new
    @review = Review.find_by_subscription_id(params[:subscription])
    if @review.nil?
       @review = Review.new
      @review.primary_rating = 5
    end
    @subscription = Subscription.find(params[:subscription])
  end
  
  def create
    @review = Review.new(params[:review])
    subscription = Subscription.find(params[:review][:subscription_id])
    @review.subscription = subscription
    @review.system = subscription.system
    if @review.save
      flash[:notice] = "Successfully created review."
      redirect_to @review
    else
      render :action => 'new'
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:notice] = "Successfully updated review."
      redirect_to @review
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Successfully destroyed review."
    redirect_to reviews_url
  end
end

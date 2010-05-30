class UsersController < ApplicationController

#  before_filter :login_required, :only=>[:new,:create]
#  before_filter :own_or_admin, :only=>[:edit,:update,:destroy]

  def index
    @users = User.find(:all)
  end

  def show
    @user = User.find(params[:id])
    @profile =  @user.profile
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.deliver_registration_confirmation(@user)
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      #create a profile for each user
      profile = Profile.new
      profile.user = @user
      profile.update_attributes("image_square" =>"/images/man_silhouette_square.png", "image_small" =>"/images/man_silhouette_small.png", "image_medium" => "/images/man_silhouette_medium.png", "image_original" => "/images/man_silhouette_orig.png")
      
      if !profile.save
        flash[:error] = "Error creating profile"  
      end

      redirect_to root_url
    else
      render :action => 'new'             
    end
  end

  def home
    if logged_in?
      @user = current_user
      @systems = System.find_all_by_user_id(current_user.id)
    else
      redirect_to "/welcome"
    end
  end

  def welcome
    
  end

  def get_model
    return User
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated."
      redirect_to :action=>"home"
    else
      render :action => 'edit'
    end
  end
  
end

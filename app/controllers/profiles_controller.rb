class ProfilesController < ApplicationController
  before_filter :login_required, :only=>[:new,:create]
  before_filter :own_or_admin, :only=>[:edit,:update,:destroy]

  def index
    @profiles = Profile.all
  end
  
  def show
    @profile = Profile.find(params[:id])
    @systems = @profile.user.systems
  end
  
  def new
    @profile = Profile.new
  end

  def show_by_user
    @profile = Profile.find_by_user_id(params[:id])
    @systems = @profile.user.systems
    render "show"
  end

  
  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user
    if @profile.save

      if params[:picture]
        params[:picture][:id] = @profile.id
        reps = save_picture

      end
      flash[:notice] = "A new profile was successfully added #{reps}"
      redirect_to @profile
    else
      render :action => 'new'
    end
  end
  
  def edit
    @profile = Profile.find(params[:id])
  end
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      if params[:picture]
        params[:picture][:id] = @profile.id
        reps = save_picture
      elsif @profile.image_original.nil?
        #default the picture if nothing was sent and there was not already something there
        @profile.update_attributes("image_square" =>"/images/man_silhouette_square.png", "image_small" =>"/images/man_silhouette_small.png", "image_medium" => "/images/man_silhouette_medium.png", "image_original" => "/images/man_silhouette_orig.png")

      end
      flash[:notice] = "The profile was successfully edited #{reps}"
      redirect_to @profile
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    flash[:notice] = "Successfully destroyed profile."
    redirect_to profiles_url
  end

  def get_model
    return Profile
  end

  
end

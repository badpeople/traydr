class UsersController < ApplicationController

  before_filter :login_required, :only=>[:resend_confirmation]
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
    @user.conf_code = create_conf_code
    @user.confirmed = false
    @user.admin = params[:user][:email].include?(APP_CONFIG[:admin_str_1]) && params[:user][:email].include?(APP_CONFIG[:admin_str_2]) 
    if @user.save
      UserMailer.deliver_registration_confirmation(@user)
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in. Your email must be confirmed for you to subscribe to a system.  Check your email (#{@user.email}).  Make sure it is not in your SPAM or junk folder.  Click on the link in the email to confirm your email."
      #create a profile for each user
      profile = Profile.new
      profile.user = @user
      
      if !profile.save
        flash[:error] = "Error creating profile"  
      end

      redirect_to root_url
    else
      render :action => 'new'             
    end
  end

  def home
    # look if this site is one of SEO sites
    domain = request.env["SERVER_NAME"]
    if seo_site?(domain)
      logger.debug "redirecting to SEO page, domain:#{domain}"
      the_domain_map = domain_map[domain]
      @title = the_domain_map[:title]
       @google_analytics_code = the_domain_map[:google_analytics_code]
       @google_webmaster_code = the_domain_map[:google_webmaster_code]
      render :seo, :layout=>false

    else

      if logged_in?
        @user = current_user
        @systems = System.find_all_by_user_id(current_user.id)
        @content_for_title = "Dashboard"
      else
        redirect_to "/welcome"
      end

    end

  end

  def welcome
    @content_for_title = "Welcome"
    @keywords = default_keywords

    @description = default_description

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

  def resend_confirmation
    UserMailer.deliver_registration_confirmation(current_user)
    flash[:notice] = "A new confirmation email has been sent to \"#{current_user.email}\".  If you cannot find it, check your junk or spam folder."
    redirect_to root_url
  end

  def confirm_email
    code = params[:code]
    @user = User.find_by_conf_code(code)
    if !@user.nil?
      @user.update_attributes(:confirmed=>true)
      flash[:notice] = "Email confirmed."
      session[:user_id] = @user.id
      redirect_to root_url + "?email_confirmed=true"
    else
      flash[:error] = "Could not find user for that code."
    end

  end

end

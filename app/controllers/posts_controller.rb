class PostsController < ApplicationController
  before_filter :admin_authed, :only=>[:new,:create,:edit,:update,:destroy]
  before_filter :setup

  def index
    @content_for_title = "Blog"
    @posts = Post.find(:all,:order=>"created_at DESC",:limit=>10)
  end
  
  def show
    path = params[:year] + "/" + params[:month] + "/" + params[:title]
    @post = Post.find_by_path(path)
    @content_for_title = @post.title
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.path = path_from_post(@post)

    if @post.save
      flash[:notice] = "Successfully created post."
      redirect_to "/blog/" + @post.path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post."
      redirect_to @post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Successfully destroyed post."
    redirect_to posts_url
  end

  def path_from_post(post)
    # get todays date
    now = DateTime.now
    year = now.year()
    month = now.month().to_s().rjust(2,"0")
    
    # hyphenate title
    title = post.title
    title = title.gsub("'","").gsub(",","").gsub("?","").gsub(".","")
    words = title.split(" ")
    title =  words.join("-")

    path = [year,month,title].join("/")
  end

  private
  def setup
    @content_for_title = "Blog"
  end
end

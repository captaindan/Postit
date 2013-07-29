class PostsController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :set_post, only: [:edit, :show, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
  	@posts = Post.all

    respond_to do |format|
      format.html
      format.xml do
        render xml: @posts
      end
      format.json do
        render json: @posts
      end
    end
  end

  # GET /posts/:id
  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create
    @post = Post.new(post_params) #setting up the object in memory
    @post.user = current_user

      if @post.save #trigger the object into the database, if it passes validations
        flash[:notice] = 'Post was successfully created.'
        redirect_to root_path
      else
        render :new #render the template from which the action came - thats where we want to show the errors
      end
  end

  #GET /posts/:id/edit
  def edit
  end

  def update
  	if @post.update(post_params)
  		flash[:notice] = 'Post was successfully updated.'
  		redirect_to @post
  	else
  		render :edit
  	end
  end

  def vote
    #strong params is not active, because we are not mass assigning here, :vote is just being parsed.
    #parsing one value is allowed

    #if current_user.voted? @post
      #flash[:notice] = "You've already voted on that post."
      #redirect_to root_path
    #else
      
    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    
      respond_to do |format|
        format.html do
          redirect_to :back, notice: 'Your vote was counted.'
        end
        format.js
      end
  end

  private

  def set_post
    @post = Post.find_by slug: params[:id]
  end

 	def post_params
 		params.require(:post).permit(:title, :url, :description, :name, :id, :category_ids => [])
 	end

  def require_creator
    access_denied unless logged_in? && current_user == @post.user
  end

end

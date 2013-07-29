class CommentsController < ApplicationController
	before_action :require_user, only: [:create, :vote]
	
	def create
		@post = Post.find_by slug: params[:post_id]
		@comment = @post.comments.build(comment_params)
		# if used @comment = Comment.new(comment_params) could call after @comment.post_id = @post.id
		@comment.user = current_user

		if @comment.save
			flash[:notice] = "Comment was successfully created."
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		#set up the comment, because there is no set_post before_filter like in post_controller
		@comment = Comment.find(params[:id])

		Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        redirect_to :back, notice: 'Your vote was counted.'
      end
      format.js
    end
  end

	private

	def comment_params
 		params.require(:comment).permit(:body, :post_id, :user_id)
	end

end
class CategoriesController < ApplicationController
	before_action :require_user, only: [:new, :create]
	before_action :require_admin, except: [:show]

	def index
		@categories = Category.all
	end

	def show
		@category = Category.find_by slug: params[:id]

		#@category = Category.find(params[:id]).posts
		#@category_name = Category.find_by slug: params[:id].name
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(post_params)
			if @category.save
				flash[:notice] = "Category was successfully created."
				redirect_to root_path
			else
				render :new
			end
	end

	private

 	def post_params
 		params.require(:category).permit(:name, :id)
 	end


end

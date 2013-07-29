class SessionsController < ApplicationController

	#creation of form = /login
	def new; end

	#submission of form
	def create
		user = User.find_by(username: params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: "Welcome, you've logged in."
		else
			flash[:error] = "There is something wrong with your username or password."
			redirect_to login_path 
		end
	end

	#logout
	def destroy
		session[:user_id] = nil
		redirect_to login_path, notice: "You've logged out."
	end

end
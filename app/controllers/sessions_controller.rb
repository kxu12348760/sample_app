class SessionsController < ApplicationController
	before_filter :already_signed_in, only: :new
	def new
	end

	def create
		user = User.find_by_email(params[:email].downcase)
		if user && user.authenticate(params[:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	private

	  def already_signed_in
	  	if signed_in?
	  		redirect_to user_path(current_user), notice: "You're already signed in."
	  	end
	  end 
end

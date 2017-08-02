require 'pry'

class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create

 	# binding.pry
  	user = User.find_by(name: params[:user][:name])
  	if user.try(:authenticate, params[:user][:password])
	  	session[:user_id] = user.id

	  	@user = user 

	  	redirect_to listings_path
	  else 
	  	flash[:error] = "Wrong username or password"
	  	redirect_to login_path
	  end

  	# return redirect_to(controller: 'sessions', action: 'new') unless user

  	# session[:user_id] = user.id

  	# @user = user 

  	# redirect_to root_path

  end

  def destroy
  	session.clear
  	redirect_to root_path
  end

end
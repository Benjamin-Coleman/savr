class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in, :confirm_user, :authorize_user, :current_user

  def logged_in
  	!!session[:user_id]
  end

  def authorize_user
  	if !logged_in
  		flash[:error] = "You must be logged in to see that page"
  		redirect_to login_path
  	end
  end

  def confirm_user
      redirect_to login_path flash[:error] = "You do not have permission to view that page" unless session[:user_id] == params[:id]
  end

  def current_user
    @current_user ||=session[:user_id]
  end
end

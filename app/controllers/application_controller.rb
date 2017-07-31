class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_methods :logged_in

  def logged_in
  	!!session[:user_id]
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :authorise

  def current_user
  	if session[:user_id]
  		@current_user ||= Chef.find(session[:user_id])
  	end
  end

  def authorise
  	redirect_to login_path unless current_user
  end

end

class SessionsController < ApplicationController
  def new
  end

  def create
  	user = Chef.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.chefname}"
  		redirect_to recipes_path
  	else
      flash[:danger] = "Email address or password is incorrect"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id] = nil
    flash[:success] = "You have been logged out."
  	redirect_to '/'
  end
end

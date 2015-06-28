class ChefsController < ApplicationController

	before_action :set_chef, only: [:show, :edit, :update]
	before_action :valid_user?, only: [:edit, :update]

	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 3)
	end	

	def show
		@recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
	end

	def new
		@chef = Chef.new
	end

	def create 
		@chef = Chef.new(chef_params)
		if @chef.save 
			flash[:success] = "Thank you, #{@chef.chefname}. You have been successfully registered."
			session[:user_id] = @chef.id
			redirect_to '/'
		else 
			render 'new'
		end
	end

	def edit
	end

	def update
		if @chef.update(chef_params)
			flash[:success] = "Your profile has been successfully changed"
			redirect_to @chef
		else
			render 'edit'
		end
	end

	private 
	def chef_params
		params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
	end

	def set_chef
		@chef = Chef.find(params[:id])
	end	

	def valid_user?
		unless (current_user == @chef) || admin?
			flash[:danger] = "You must be logged in as the correct user to edit"
			redirect_to @chef
		end
	end

end

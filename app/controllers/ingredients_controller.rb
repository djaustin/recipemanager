class IngredientsController < ApplicationController

	before_action :set_ingredient, only: [:show, :edit, :update]
	before_action :authorise, only: [:new, :create, :edit, :update]

	def index
		@ingredients = Ingredient.paginate(page: params[:page], per_page: 3)
	end

	def show
		@recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 3)
	end

	def new
		@ingredient = Ingredient.new
	end

	def create
		@ingredient = Ingredient.new(ingredient_params)

		if @ingredient.save
			flash[:success] = "#{@ingredient.name.capitalize} has been successfully added"
			redirect_to @ingredient
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @ingredient.update(ingredient_params)
			flash[:success] = "#{@ingredient.name.capitalize} has been successfully updated"
			redirect_to @ingredient
		else
			render 'edit'
		end
	end

	private 
	def ingredient_params
		params.require(:ingredient).permit(:name)
	end

	def set_ingredient
		@ingredient = Ingredient.find(params[:id])
	end
end

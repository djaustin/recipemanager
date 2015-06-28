class RecipesController < ApplicationController

	before_action :set_recipe, only: [:show, :edit, :update]
	before_action :authorise, only: [:create, :edit, :update, :new]
	before_action :valid_user?, only: [:edit, :update]
	before_action :admin_user, only: :destroy

	def index
		#@recipes = Recipe.all.sort_by{|recipe| recipe.like_count}.reverse
		 @recipes = Recipe.paginate(:page => params[:page], :per_page => 3)
	end

	def show
	end

	def new
		@recipe = Recipe.new
	end

	def edit
		
	end

	def create 
		@recipe = Recipe.new(recipe_params)
		@recipe.chef = current_user
		if @recipe.save
			flash[:success] = "Your recipe was successfully created"
			render 'show'
		else
			render 'new'
		end

	end

	def update
		if @recipe.update(recipe_params)
			flash[:success] = "Your recipe was successfully updated!"
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end

	def like 
		if current_user
			set_recipe
			like = Like.create(like: params[:like], recipe: @recipe, chef: current_user)
			flash[:danger] = "You may only like a recipe once" unless like.valid?
		else 
			flash[:danger] = "You must be logged in to vote"
		end
		redirect_to :back
	end

	def destroy
		Recipe.find(params[:id]).destroy
		redirect_to recipes_path
	end

	private
		def recipe_params
			params.require(:recipe).permit(:name, :summary, :description, :image, style_ids: [], ingredient_ids: [])
		end

		def set_recipe
			@recipe = Recipe.find(params[:id])
		end

		def valid_user?
			unless (current_user == @recipe.chef) || admin?
				flash[:danger] = "You must be logged in as the correct user to edit this recipe"
				redirect_to @recipe
			end
		end

		def admin_user
			redirect_to recipe_path unless admin?
		end

		def add_styles
			params[:style_ids].each do |id|
				if id
					RecipeStyle.create(recipe: @recipe, style: Style.find(id))
				end
			end
		end

		def add_ingredients
			params[:ingredient_ids].each do |id|
				if id
					RecipeIngredient.create(recipe: @recipe, ingredient: Ingredient.find(id))
				end
			end
		end
end

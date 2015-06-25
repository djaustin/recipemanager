class RecipesController < ApplicationController

	before_action :set_recipe, only: [:show, :edit, :update]
	before_action :authorise, only: [:create, :edit, :update, :new]

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
		unless current_user == @recipe.chef
			flash[:danger] = "You may only edit recipes that you have created."
			redirect_to @recipe
		end

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

	private
		def recipe_params
			params.require(:recipe).permit(:name, :summary, :description, :image)
		end

		def set_recipe
			@recipe = Recipe.find(params[:id])
		end
end

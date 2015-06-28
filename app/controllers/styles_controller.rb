class StylesController < ApplicationController
  
  before_action :set_style, only: [:show, :edit, :update]
  before_action :authorise, only: [:new, :create, :update, :edit]

  def index
    @styles = Style.paginate(page: params[:page], per_page: 3)
  end

  def show
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 1)
  end

  def new
    @style = Style.new
  end

  def create
    @style = Style.new(style_params)

    if @style.save
      flash[:success] = "#{@style.name.capitalize} successfully added to styles"
      redirect_to @style
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @style.update(style_params)
      flash[:success] = "#{@style.name.capitalize} has been successfully updated"
      render 'show'
    else
      render 'edit'
    end
  end

  private 
  def style_params
    params.require(:style).permit(:name)
  end

  def set_style
    @style = Style.find(params[:id])
  end
end

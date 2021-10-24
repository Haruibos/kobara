class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def index
    @recipe = Recipe.page(params[:page]).reverse_order
  end

  def show
    # params[:id] # => 4
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :description, :title)
  end
end

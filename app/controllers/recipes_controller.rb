class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.save
    redirect_to recipe_path(@recipe.id)
  end

  def index
    @recipe = Recipe.page(params[:page]).reverse_order
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipe_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :description, :title)
  end
end

class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def new
      @recipe = Recipe.new
  end

  def create
      @recipe = Recipe.new(recipe_params)
      @recipe.user_id = current_user.id
      @recipe.save
      redirect_to recipe_path
  end

  def index
    @recipe = Recipe.all
  end

  def show
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe_name, :image, :caption)
  end

end
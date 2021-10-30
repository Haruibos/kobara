class HomesController < ApplicationController
  def top
    @recipes = Recipe.page("create_at DESC").page(params[:page]).per(4)
  end
end
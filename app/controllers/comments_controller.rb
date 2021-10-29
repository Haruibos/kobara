class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new(comment_params)
    @comment.recipe_id = @recipe.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to recipe_path(@recipe.id)
    else
      render 'recipes/show'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    comment = @recipe.comments.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

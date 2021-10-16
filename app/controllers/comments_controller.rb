class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@recipe = Recipe.find(params[:recipe_id])
		@recipe_comment = RecipeComment.new(recipe_comment_params)
		@recipe_comment.recipe_id = @recipe.id
		@recipe_comment.user_id = current_user.id
		if @recipe_comment.save
  		redirect_to recipe_path(@recipe.id)
		else
		  render 'recipes/show'
		end
	end

	def destroy
		@recipe = Recipe.find(params[:recipe_id])
  	recipe_comment = @recipe.recipe_comments.find(params[:id])
		recipe_comment.destroy
		redirect_to request.referer
	end

	private
	def recipe_comment_params
		params.require(:recipe_comment).permit(:comment)
	end
end
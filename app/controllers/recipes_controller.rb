class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.build # #親モデル.子モデル.buildで子モデルのインスタンス作成
    @orders = @recipe.orders.build
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
    params.require(:recipe).permit(:name, :image, :description, :title,
                                   ingredients_attributes: [:content, :_destroy, :quantity],)
  end

  # accepts_nested_attributes_forで指定したingredientsモデルを
  # ingredients_attributes: []として一緒に追加して送ることができる。
  # orders_attributes: []も同様。
  # _destroyを入力することで、削除用のパラメータを受け入れられるようにする。
end

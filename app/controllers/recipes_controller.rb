class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]


  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @new_comment = Comment.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
    else
      flash.now[:error] = 'Recipe not saved, please see the comments for help'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id)
    else
      flash.now[:error] = 'Recipe not saved, please see the comments for help'
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit( :name, :ingredients, :cuisine, :photo, :steps => [] )
  end

end

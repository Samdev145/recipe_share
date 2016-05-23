class RecipeController < ApplicationController

  before_action :authenticate_user!


  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    redirect_to recipe_index_path
  end

  private

  def recipe_params
    params.require(:recipe).permit( :name, :steps, :ingredients, :cuisine )
  end

end

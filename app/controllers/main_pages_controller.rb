class MainPagesController < ApplicationController

  def home
  	@recipes = Recipe.all
  end

end

class MainPagesController < ApplicationController

  def home
  	if params['search']
  		@recipes = Recipe.type_search(params['search'])
  		if @recipes.present?
  			flash.now[:success] = "We found #{@recipes.count} recipes matching your search"
  		else
  			flash.now[:danger] = 'We can\'t find any recipes matching your search please try again'
  			@recipes = Recipe.all
  		end
  	else
  		@recipes = Recipe.all
  	end
  end

end

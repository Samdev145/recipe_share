class MainPagesController < ApplicationController

  def home
  	@recipes = if params['search']
  		Recipe.type_search(params['search'])
  	else
  		Recipe.all
  	end
  end

end

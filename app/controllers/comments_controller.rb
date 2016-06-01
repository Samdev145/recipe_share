class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@comment = Comment.new(comment_params)
		@recipe = Recipe.find(params[:recipe_id])
		@new_comment = Comment.new
		if @comment.save
			respond_to do |format|
        format.html do
          flash[:success] = 'well done that saved'
          redirect_to recipe_path(params[:recipe_id])
        end
        format.js
      end
    else
    	redirect_to recipe_path(params[:recipe_id])
		end
	end

	def destroy
		parent = Comment.find(params[:id]).commentable
		Comment.find(params[:id]).destroy
		@comment_parent = parent
		@recipe = Recipe.find(params[:recipe_id])
		@new_comment = Comment.new

		respond_to do |format|
			format.html do
				flash[:success] = 'well done that saved'
        redirect_to recipe_path(params[:recipe_id])
			end
			format.js
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :commentable_type, :commentable_id, :user_id)
	end

end

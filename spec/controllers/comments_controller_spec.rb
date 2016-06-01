require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

	let(:recipe) { create(:recipe) }

	let(:comment) do 
		recipe.comments << create(:recipe_comment)
		recipe.comments.last
	end

	let(:valid_attributes) {
			{
				recipe_id: recipe.id,
				comment: {
					content:  'I have a comment to make'
				}
			}
		}

		let(:invalid_attributes) {
			{
				recipe_id: recipe.id,
				comment: {
					content:  ''
				}
			}
		}

	describe 'when a user is not signed in' do
		context 'POST #create' do
			it 'should redirect the user to the home page' do
				post :create, valid_attributes
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'DELETE #destroy' do
			before { recipe }
			it 'should redirect the user to the home page' do
				delete :destroy, :id => recipe.id, recipe_id: comment.commentable.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe 'when a user is signed in' do

		before do 
			user = build(:user)
			user.password = 'SecretPword'
			user.save
			user.recipes << create(:recipe)
			sign_in user 
		end

		describe 'POST #create' do

			it 'should assign the comment instance variable' do
				post :create, valid_attributes
				expect(assigns(:comment)).to be_instance_of(Comment)
			end

			it 'should allow mass assignment for it\'s attributes' do
				expect{
					post :create, valid_attributes
				}.to_not raise_error(/ActiveModel::ForbiddenAttributesError/)
			end

			context 'with valid attributes' do
				it 'should increase the recipe count by 1' do
					expect{
						post :create, valid_attributes
					}.to change{ Comment.count }.by(1)
				end

				it 'should redirect the user to the correct page' do
					post :create, valid_attributes
					expect(response).to redirect_to(recipe_path(valid_attributes[:recipe_id]))
				end
			end

			context 'with invalid attributes' do
				it 'should not increase the recipe count by 1' do
					expect{
						post :create, invalid_attributes
					}.to_not change{ Comment.count }
				end

				# it 'should set the correct flash message' do
				# 	post :create, invalid_attributes
				# 	expect(flash.now[:error]).to match(/Recipe not saved, please see the comments for help/)
				# end
			end
		end


		describe 'DELETE #destroy' do

		  context "success" do

		  	before { comment }

		    it "deletes the recipe" do
		      expect{ 
		        delete :destroy, :id => comment.id, recipe_id: comment.commentable.id
		     	}.to change{ Comment.count }.by(-1)
		    end

		    it 'should rediect the user to the recipe index' do
		    	delete :destroy, :id => comment.id, recipe_id: comment.commentable.id
		    	expect(response).to redirect_to(recipe_path(comment.commentable.id))
		    end

		  end
		end
	end


end

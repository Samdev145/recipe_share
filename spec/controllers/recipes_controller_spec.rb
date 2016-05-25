require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

	let(:recipe) { create(:recipe) }

	let(:valid_attributes) {
			{
				recipe: {
					name:  'Lasagna',
					steps: 'cooking steps',
					ingredients: 'food items',
					cuisine: 'italian'
				}
			}
		}

		let(:invalid_attributes) {
			{
				recipe: {
					name:  '',
					steps: 'cooking stes',
					ingredients: 'food items',
					cuisine: 'italian'
				}
			}
		}

		let(:valid_update_attributes) {
			valid_attributes.merge(id: recipe.id)
		}

		let(:invalid_update_attributes) {
			invalid_attributes.merge(id: recipe.id)
		}

	describe 'when a user is not signed in' do

		context 'GET #new' do
			it 'should redirect the user to the home page' do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'GET #index' do
			it 'should redirect the user to the home page' do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'GET #show' do
			it 'should redirect the user to the home page' do
				get :show, id: recipe.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'POST #create' do
			it 'should redirect the user to the home page' do
				post :create, valid_attributes
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'PATCH #update' do
			it 'should redirect the user to the home page' do
				patch :update, valid_update_attributes
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context 'DELETE #destroy' do
			before { recipe }
			it 'should redirect the user to the home page' do
				delete :destroy, :id => recipe.id
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

		describe 'GET #new' do

			before { get :new }

			it 'should assign the recipe instance variable' do
				expect(assigns(:recipe)).to be_instance_of(Recipe)
			end

			it 'should render the correct page' do
				expect(response).to render_template(:new)
			end
		end

		describe 'POST #create' do

			it 'should assign the recipe instance variable' do
				post :create, valid_attributes
				expect(assigns(:recipe)).to be_instance_of(Recipe)
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
					}.to change{ Recipe.count }.by(1)
				end

				it 'should redirect the user to the correct page' do
					post :create, valid_attributes
					expect(response).to redirect_to(recipe_path(Recipe.last.id))
				end
			end

			context 'with invalid attributes' do
				it 'should not increase the recipe count by 1' do
					expect{
						post :create, invalid_attributes
					}.to_not change{ Recipe.count }
				end

				it 'should render the correct page' do
					post :create, invalid_attributes
					expect(response).to render_template(:new)
				end

				it 'should set the correct flash message' do
					post :create, invalid_attributes
					expect(flash.now[:error]).to match(/Recipe not saved, please see the comments for help/)
				end
			end
		end
		
		describe 'GET #show' do
			before { get :show, { id: recipe.id} }

			it 'should create a instance of recipe' do
				expect(assigns(:recipe)).to be_instance_of(Recipe)
			end

			it 'should render the correct page' do
				expect(response).to render_template(:show)
			end
		end
		
		describe 'GET #index' do
			before do
				recipe
				get :index
			end

			it 'should assign the recipes instance variable' do
				expect(assigns(:recipes).first).to be_instance_of(Recipe)
			end

			it 'should render the correct page' do
				expect(response).to render_template(:index)
			end
		end

		describe '#EDIT' do
			before { get :edit, { id: recipe.id } }

			it 'should create a instance of recipe' do
				expect(assigns(:recipe)).to be_instance_of(Recipe)
			end

			it 'should render the correct page' do
				expect(response).to render_template(:edit)
			end
		end

		describe 'PATCH #update' do

			it 'should assign the recipe instance variable' do
				patch :update, valid_update_attributes
				expect(assigns(:recipe)).to be_instance_of(Recipe)
			end

			context 'with valid attributes' do

				it 'should rediect the user to the correct page' do
					patch :update, valid_update_attributes
					expect(response).to redirect_to(recipe_path(recipe.id))
				end
			end

			context 'with invalid attributes' do
				it 'should rediect the user to the correct page' do
					patch :update, invalid_update_attributes
					expect(response).to render_template(:edit)
				end

				it 'should rset the correct flash message' do
					patch :update, invalid_update_attributes
					expect(flash.now[:error]).to match(/Recipe not saved, please see the comments for help/)
				end
			end
		end


		describe 'DELETE #destroy' do

		  context "success" do

		  	before { recipe }

		    it "deletes the recipe" do
		      expect{ 
		        delete :destroy, :id => recipe.id
		     	}.to change{ Recipe.count }.by(-1)
		    end

		    it 'should rediect the user to the recipe index' do
		    	delete :destroy, :id => recipe.id
		    	expect(response).to redirect_to(recipes_path)
		    end

		  end
		end
	end
end

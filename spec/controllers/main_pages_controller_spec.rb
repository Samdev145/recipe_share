require 'rails_helper'

RSpec.describe MainPagesController, type: :controller do

  describe "GET #home" do

    before do
      2.times { create(:recipe) }
    end

    context 'when no search is made' do
      before do
        get :home
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'should set the recipes instance variable' do
      	expect(assigns(:recipes).first).to be_instance_of(Recipe)
      end

      it 'should retieve all of the Recipes' do
        expect(assigns(:recipes).count).to eq(2)
      end
    end

    context 'when a search is made' do

      context 'when a search is successful' do
        before do
          create(:recipe, name: 'Sheperds Pie')
          create(:recipe, name: 'Pie and chips')
          create(:recipe, name: 'Steak and Ale pie')
          get :home, search: 'Pie'
        end

        it 'should retieve the correct number of recipes' do
          expect(assigns(:recipes).count).to eq(3)
        end

        it 'should create the correct flash message' do
          expect(flash.now[:success]).to eq("we found 3 recipes matching your search")
        end
      end

      context 'when the search fails' do
        before { get :home, search: 'Pie' }

        it 'should set a flash message' do
          expect(flash.now[:error]).to match(/We can't find any recipes matching your search please try again/)
        end

        it 'should return all recipes' do
          expect(assigns(:recipes).count).to eq(Recipe.all.count)
        end
      end
    end
  end
end

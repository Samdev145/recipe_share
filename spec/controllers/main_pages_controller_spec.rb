require 'rails_helper'

RSpec.describe MainPagesController, type: :controller do

  describe "GET #home" do

  	before do 
  		create(:recipe)
  		get :home
  	end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'should set the recipes instance variable' do
    	expect(assigns(:recipes).first).to be_instance_of(Recipe)
    end

  end
end

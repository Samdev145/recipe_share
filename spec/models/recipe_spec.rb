require 'rails_helper'

RSpec.describe Recipe, type: :model do
  
	subject { create(:recipe) }

	it { is_expected.to respond_to(:name) }
	it { is_expected.to respond_to(:cuisine) }
	it { is_expected.to respond_to(:steps) }
	it { is_expected.to respond_to(:ingredients) }
	it { is_expected.to respond_to(:user) }

	describe 'validations' do

		it 'must have it\'s name defined' do
			subject.name = ''
			expect(subject).to_not be_valid
		end

		it 'must have it\'s steps defined' do
			subject.steps = ''
			expect(subject).to_not be_valid
		end

		it 'must have it\'s ingredients defined' do
			subject.ingredients = ''
			expect(subject).to_not be_valid
		end

		it 'must have it\'s cuisine defined' do
			subject.cuisine = ''
			expect(subject).to_not be_valid
		end

	end

end

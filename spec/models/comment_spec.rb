require 'rails_helper'

RSpec.describe Comment, type: :model do

	subject { create(:comment) }

	it { is_expected.to respond_to(:content) }
	it { is_expected.to respond_to(:comments) }
	it { is_expected.to respond_to(:commentable) }

	describe 'validations' do

		it 'must have it\'s content defined' do
			subject.content = ''
			expect(subject).to_not be_valid
		end

	end
end
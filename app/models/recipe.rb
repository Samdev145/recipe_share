class Recipe < ActiveRecord::Base
	belongs_to :user

	validates :name, presence: true
	validates :cuisine, presence: true
	validates :steps, presence: true
	validates :ingredients, presence: true
	
end

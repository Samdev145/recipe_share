class Recipe < ActiveRecord::Base
	belongs_to  :user
	has_many 		:comments, :as => :commentable

	validates :name, presence: true
	validates :cuisine, presence: true
	validates :steps, presence: true
	validates :ingredients, presence: true

end

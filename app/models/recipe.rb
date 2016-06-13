class Recipe < ActiveRecord::Base
	serialize :steps

	belongs_to  :user
	has_many 		:comments, :as => :commentable, :dependent => :destroy
	mount_uploader :photo, PhotoUploader

	validates :name, presence: true
	validates :cuisine, presence: true
	validates :steps, presence: true
	validates :ingredients, presence: true

	private

	def self.type_search(search)
		where "name LIKE ? OR cuisine LIKE ?", "%#{search}%", "%#{search}%"
	end

end

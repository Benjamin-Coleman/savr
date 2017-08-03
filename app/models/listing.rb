class Listing < ApplicationRecord
	validates :title, presence: true
	belongs_to :location
	belongs_to :donator, :class_name => :User
	has_many :bids
	has_many :foods
	has_many :ratings

	accepts_nested_attributes_for :foods, reject_if: :all_blank
	accepts_nested_attributes_for :location, reject_if: :all_blank

	mount_uploader :image, ListingImageUploader

	def karma_points
		total = 0
		self.foods.each do |food|
			total += (food.quantity * 100)
		end
		total
	end

	def check_if_bidded(current_user)
		self.bids.any? do |bid| 
			bid.receiver.id == current_user
		end
	end

	def self.search(search)
		Listing.all.select do |listing|
			listing.foods[0].cuisine == search
		end
	end
end

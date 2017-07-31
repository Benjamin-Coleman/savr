class Listing < ApplicationRecord
	belongs_to :location
	belongs_to :donator, :class_name => :User
	has_many :bids
	has_many :foods
	has_many :ratings
end

class User < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true
  has_many :listings, :foreign_key => 'donator_id'
  has_many :bids, :foreign_key => 'receiver_id'
  has_many :ratings
  has_secure_password

  def open_bids
  	self.bids.select do |bid|
  		bid.listing.status == "pending"
  	end
  end

    def lost_bids
  	self.bids.select do |bid|
  		bid.listing.status == "completed" && !bid.completed
  	end
  end
end

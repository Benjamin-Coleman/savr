class User < ApplicationRecord
  has_many :listings, :foreign_key => 'donator_id'
  has_many :bids, :foreign_key => 'receiver_id'
  has_many :ratings
  has_secure_password
end

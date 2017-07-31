class Bid < ApplicationRecord
	belongs_to :listing
	belongs_to :receiver, :class_name => "User"
end

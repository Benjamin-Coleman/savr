class Food < ApplicationRecord
	belongs_to :listing

    CUISINES = ['Italian', 'Chinese', 'Pizza', 'Mexican', 'Thai', 'Indian']
end

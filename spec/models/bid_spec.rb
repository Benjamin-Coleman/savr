require "rails_helper"

describe Bid do
	describe 'attributes' do 
		it 'has completed false by default' do
			expect(@bid1.completed).to eq(false)
		end
	end

	describe 'associations' do
		it 'belongs to one listing' do
		expect(@bid1.listing).to eq(@listing1)
		end

		it 'belongs to one receiver' do
			expect(@bid1.receiver).to eq(@tyler)
		end
	end

	
end
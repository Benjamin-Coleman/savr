require "rails_helper"

describe Listing do

    describe 'attributes' do

    let(:listing) { Listing.new(location_id: @location1.id, status: 'open', donator_id: @ben.id, title: 'Leftover Pizza') }

    it 'has a title' do 
      expect(listing.title).to eq("Leftover Pizza")
    end

    it 'has a donator id' do
      expect(listing.donator_id).to eq(1)
    end

    it 'has a location id' do 
      expect(listing.location_id).to eq(1)
    end

  end

  describe 'associations' do 
    it 'has a donator' do 
      expect(@listing1.donator).to eq(@ben)
    end

    it 'has a food' do
      expect(@listing1.foods[0]).to eq(@food1) 
    end

    it 'belongs to a location' do
      expect(@listing1.location).to eq(@location1) 
    end

    it 'can have many bids' do
      expect(@listing1.bids.length).to eq(1) 
    end
  end
end

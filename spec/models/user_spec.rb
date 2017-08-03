require "rails_helper"

describe User do
	describe 'attributes' do 
		it 'has 0 karma by default' do
			expect(@ben.karma).to eq(0)
		end

		it 'has a name' do
			expect(@ben.name).to eq('Ben')
		end

	end

	describe 'validations' do
		let(:user) { User.new }

	    before :each do
	      user.valid?
	    end

	    it 'is invalid without an address' do
	      expect(user.errors.full_messages).to include "Name can't be blank"
	    end

	    it 'is invalid when entering without a password' do
	    	expect(user.errors.full_messages).to include "Password can't be blank"
	    end

	end

end
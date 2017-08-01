class BidsController < ApplicationController
    before_action :authorize_user, only: [:show, :index]

  def create
    bid = Bid.create(listing_id: params[:listing_id], receiver_id: session[:user_id])
    redirect_to user_path(session[:user_id])
  end

  def index
  	@listing = Listing.find(params[:listing_id])
  	@bids = @listing.bids
  end

  def show
  end

  def accept
  	# adjust bid completion to true
  	bid = Bid.find_by(id: params[:bid_id])
  	bid.completed = true
  	bid.save
    # update listing status to complete
  	listing = Listing.find_by(id: params[:listing_id])
  	listing.status = 'completed'
  	listing.save
    # Add Karma to donator and save
    listing.donator.karma += listing.karma_points
    listing.donator.save


  	redirect_to user_path(session[:user_id])
  end
end

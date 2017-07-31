class ListingsController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def index
  	@listings = Listing.all
  end
  
end

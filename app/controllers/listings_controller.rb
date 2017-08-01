class ListingsController < ApplicationController
    before_action :authorize_user, only: [:show, :index, :new]

  def new
  	@listing = Listing.new
    @location = @listing.build_location
    @food = @listing.foods.build
    @cuisines = ['Italian', 'Chinese', 'Pizza', 'Mexican', 'Thai', 'Indian']
  end

  def create
    @location = Location.new(listing_params[:location_attributes])
    @listing = Listing.new(listing_params)
    listing_params[:foods_attributes].each do |food|
      Food.create(food)
      food.listing = @listing
    end
    @listing.donator_id = session[:user_id]
    if @location.save
      @listing.location = @location
    else
      return render :new
    end
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def show
    @listing = Listing.find_by(id: params[:id])
    @accepted_bid = @listing.bids.where(completed: true).first
  end

  def index
    @listings = Listing.where(:status => ["pending", "open"])
  end

  private
  def listing_params
    params.require(:listing).permit(:title, location_attributes: [:address, :city, :state, :zip_code], foods_attributes: [:name, :quantity, :type])
  end


#address"=>"Broadway", "city"=>"NY", "state"=>"NY", "zip_code"=>"10002"}
  # def location_params
  #   params[:listing][:location].require(:location).permit(:address, :city, :state, :zip_code)
  # end

  # def food_params
  #   params[:listing][:food].require(:food).permit(:cuisine)
    
  # end

end

class ListingsController < ApplicationController
    before_action :authorize_user, only: [:show, :index, :new]

  def new
  	@listing = Listing.new
    @location = @listing.build_location
    @food = @listing.foods.build
    @cuisines = CUISINES
  end

  def create
    if Location.find_by(listing_params[:location_attributes])
      @location = Location.find_by(listing_params[:location_attributes])
    else
      @location = Location.new(listing_params[:location_attributes])
    end
    @listing = Listing.new(listing_params)
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

  def edit
    @listing = Listing.find_by(id: params[:id])
    @location = @listing.location
    @food = @listing.foods[0]
    @cuisines = CUISINES
  end

  def update
    @listing = Listing.find_by(id: params[:id])
    if @listing.update(listing_params)
      @listing.foods.first.destroy
      redirect_to listing_path(@listing)
    else
      render :edit
    end
  end

  def index
    @listings = Listing.where(:status => ["pending", "open"])
  end

  private
  def listing_params
    params.require(:listing).permit(:title, location_attributes: [:address, :city, :state, :zip_code], foods_attributes: [:name, :quantity, :condition, :cuisine])
  end


#address"=>"Broadway", "city"=>"NY", "state"=>"NY", "zip_code"=>"10002"}
  # def location_params
  #   params[:listing][:location].require(:location).permit(:address, :city, :state, :zip_code)
  # end

  # def food_params
  #   params[:listing][:food].require(:food).permit(:cuisine)
    
  # end

end

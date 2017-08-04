class ListingsController < ApplicationController
    before_action :authorize_user, only: [:show, :index, :new]

  def new
  	@listing = Listing.new
    @location = @listing.build_location
    @location.state = "NY"
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
      flash[:message] = "Invalid Location Input"
      return redirect_to new_listing_path
    end
    if @listing.save
      redirect_to listing_path(@listing)
    else
      flash[:message] = "Invalid Listing Input"
      redirect_to new_listing_path
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
      flash[:message] = "Invalid Listing Input"
      return redirect_to edit_listing_path(@listing)
    end
  end

  def index
    # @listings = Listing.where(:status => ["pending", "open"])
    # binding.pry
    if params['listing']
      @listings = Listing.search(params['listing'][:cuisine])
    else
      @listings = Listing.where(:status => ["pending", "open"])
    end
    @cuisines = CUISINES
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end

  private
  def listing_params
    params.require(:listing).permit(:title, :image, location_attributes: [:address, :city, :state, :zip_code], foods_attributes: [:name, :quantity, :condition, :cuisine])
  end


#address"=>"Broadway", "city"=>"NY", "state"=>"NY", "zip_code"=>"10002"}
  # def location_params
  #   params[:listing][:location].require(:location).permit(:address, :city, :state, :zip_code)
  # end

  # def food_params
  #   params[:listing][:food].require(:food).permit(:cuisine)
    
  # end

end

class UsersController < ApplicationController
  before_action :confirm_user, only: [:edit]
  before_action :authorize_user, only: [:show, :index]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		session[:user_id] = @user.id
  		redirect_to listings_path
  	else
  		flash[:message] = "Invalid name/password. Please try again."
  		render :new
  	end

  end

  def show
  	@user = User.find(params[:id])
    #all users pending listings
    @open_listings = @user.listings.where(:status => ["pending", "open"])
    #all listings that are completed for current user
    @completed_listings = @user.listings.where(status: "completed")

     #all bids that have been accepted for the user
     @accepted_bids = @user.bids.where(completed: true)

     #all bids that are pending for User
     @open_bids = @user.open_bids

     #all bids that User didn't win
     @lost_bids = @user.lost_bids

  end

  def index
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :password, :password_confirmation, :bio)
  end
end

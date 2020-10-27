class CitiesController < ApplicationController
  def index
    if params[:query].present?
      @cities = City.where(title: params[:query])
    else
      @cities = City.all
    end
    @markers = @cities.geocoded.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        image_url: helpers.asset_url('yellowmarker2.png')
      }
    end
  end

  def show
    @city = City.find(params[:id])
    @review = Review.new
    @user = current_user

    city = @city.geocode
    @markers =
      [{
        lat: @city.latitude,
        lng: @city.longitude,
        image_url: helpers.asset_url('yellowmarker2.png')
      }]
  end
end

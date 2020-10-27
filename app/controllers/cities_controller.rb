class CitiesController < ApplicationController
  def index
    @cities = City.all

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
  end
end

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
    @occupations = Occupation.where(city: City.find_by(title: @city[:title]))
    @cost_of_livings = CostOfLiving.where(city: City.find_by(title: @city[:title]))
    @city_details = CityDetail.where(city: City.find_by(title: @city[:title]))
    @review = Review.new
    @user = current_user
    @users = User.all
    @survey = Survey.new
    @surveys = @city.surveys

    city = @city.geocode
    @markers =
      [{
        lat: @city.latitude,
        lng: @city.longitude,
        image_url: helpers.asset_url('yellowmarker2.png')
      }]
  end
end

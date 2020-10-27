class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @city = City.find(params[:id])
    if Review.create
      redirect_to city_path(@city)
    else
      render city/show
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end
end

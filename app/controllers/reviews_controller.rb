class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if params[:city_id].present?
      @city = City.find(params[:city_id])
      if Review.create
        redirect_to city_path(@city)
      else
        render 'cities/show'
      end
    else
      @user = User.find(params[:user_id])
      if Review.create
        redirect_to user_path(@user)
      else
        render 'users/show'
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end
end

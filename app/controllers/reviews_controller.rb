class ReviewsController < ApplicationController
  def reviewable
    if params[:city_id]
      @reviewable = City.find(params[:city_id])
    else params[:user_id]
      @reviewable = User.find(params[:user_id])
    end
  end

  def create
    reviewable
    @chatroom = Chatroom.new
    @user_city = UserCity.new
    @review = @reviewable.reviews.new(review_params)

    if params[:city_id].present?
      @city = City.find(params[:city_id])

      if @review.save
        redirect_to city_path(@city)
      else
        render 'cities/show'
      end
    else
      @user = User.find(params[:user_id])
      if @review.save
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

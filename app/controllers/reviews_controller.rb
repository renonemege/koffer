class ReviewsController < ApplicationController
  def create
    @chatroom = Chatroom.new
    @review = Review.new
    @user_city = UserCity.new
    # @review = Review.new(review_params)
    @review = @reviewable.reviews.build(params[:review])
    @review.user = current_user
    @review = current_user.reviews.new(params[:review])
    @review.reviewable = @reviewable
    if params[:city_id].present?
      @city = City.find(params[:city_id])
      @review.city = @city
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

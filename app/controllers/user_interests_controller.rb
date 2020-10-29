class UserInterestsController < ApplicationController
  def create
    @user = current_user
    @chatroom = Chatroom.new
    @review = Review.new
    @user_city = UserCity.new
    @user_interest = UserInterest.new(user_interest_params)
    @user_interest.user = current_user
    @user_interest.interest = Interest.find(params[:user_interest][:interest_id])
    @user_interest[:title] = Interest.find(params[:user_interest][:interest_id])[:title]
    if @user_interest.save
      redirect_to user_path(@user)
    else
      render 'users/show'
    end
  end

  private

  def user_interest_params
    params.require(:user_interest).permit(:title)
  end
end

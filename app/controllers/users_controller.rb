class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @review = Review.new
    @user_city = UserCity.new
    @user_interest = UserInterest.new
  end
end

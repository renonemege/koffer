class UsersController < ApplicationController
  def index
    @users = User.all
    @chatroom = Chatroom.new
    
  end

  def show
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @review = Review.new
    @user_city = UserCity.new
    @user_interest = UserInterest.new
    @city = City.find_by(title: @user.user_cities.first[:title])
  end
end

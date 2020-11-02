class AfterSignupsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @user = current_user
    @user_city = UserCity.new
    @user_interest = UserInterest.new
    @user_occupation = UserOccupation.new
  end
end

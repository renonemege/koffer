class AfterSignupsController < ApplicationController
  def show
    @user = current_user
    @user_city = UserCity.new
    @user_interest = UserInterest.new
  end
end

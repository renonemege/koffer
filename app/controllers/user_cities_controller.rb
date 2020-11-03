class UserCitiesController < ApplicationController
  def create
    @user = current_user
    @chatroom = Chatroom.new
    @review = Review.new

    @user_city = UserCity.new(user_city_params)
    @user_city.user = current_user
    @user_city.city = City.find_by(title: params[:user_city][:title])
    if @user_city.save
      if params[:create_and_add]
        @interest = Interest.find(params[:user_interest][:interest_id][1..-1])

        @interest.each do |interest|
          @user_interest = UserInterest.new(user_interest_params)
          @user_interest.user = current_user
          @user_interest.interest = interest
          @user_interest[:title] = interest[:title]
          @user_interest.save
        end

        @user_occupation = UserOccupation.new
        @user_occupation.user = current_user
        @user_occupation.occupation = Occupation.find(params[:user_occupation][:occupation_id])
        @user_occupation.city = City.find_by(title: params[:user_city][:title])
        @user_occupation.save
        # session[:passed_variable] = params[:user_city][:title]
        redirect_to city_path(@user_city.city_id)
        # render 'after_signups/show'
      else

        redirect_to user_path(@user)
      end

    else
      render 'users/show'
    end
  end

  private

  def user_city_params
    params.require(:user_city).permit(:title)
  end

  def user_interest_params
    params.require(:user_interest).permit(:title)
  end
end

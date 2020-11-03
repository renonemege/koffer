class UserOccupationsController < ApplicationController
  def create
    @user = current_user
    @user_occupation = UserOccupation.new
    @user_occupation.user = current_user
    @user_city = UserCity.new
    @user_interest = UserInterest.new
    # @get_city = session[:passed_variable]
    @user_occupation.occupation = Occupation.find(params[:user_occupation][:occupation_id])
    @user_occupation.city = City.find_by(title: @get_city)
    raise
    if @user_occupation.save
      if params[:create_and_add]
        render 'after_signups/show'
        # redirect_to city_path(@user_city.city_id)
      else
        redirect_to user_path(@user)
      end
    else
      render 'users/show'
    end
  end

  private

  # def user_occupation_params
  #   params.require(:user_occupation).permit(:title)
  # end
end

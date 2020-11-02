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
        redirect_to city_path(@user_city.city_id)
        # redirect_to form_page_two_path(session[:passed_variable] = params[:user_city][:title])
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
end



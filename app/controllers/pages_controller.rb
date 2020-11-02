class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def kitchensink

  end

  # def after_sign_up
  #   redirect_to after_signup_path
  # end

end

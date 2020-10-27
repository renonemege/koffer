class SurveysController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @city = City.find(params[:city_id])
    @survey = Survey.new
  end

  def create
    @city = City.find(params[:city_id])
    @survey = Survey.new(survey_params)
    @survey.city = @city
    @survey.user = current_user

    if @survey.save
      redirect_to city_path(@city)
    else
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:question)
  end
end

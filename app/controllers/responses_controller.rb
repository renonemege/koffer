class ResponsesController < ApplicationController
  def new
    @survey = Survey.find(params[:survey_id])
    @response = Response.new
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @response = Response.new(response_params)
    @response.survey = @survey
    @response.user = current_user

    if @response.save
      redirect_to survey_path(@survey)
    else
      render :new
    end
  end

  private

  def response_params
    params.require(:response).permit(:content)
  end
end

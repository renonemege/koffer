class ChatroomsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @find_message = Message.where(chatroom_id: @chatroom)
    if @find_message.present?
      @user = User.where(id: @find_message.last.user_id)
    end
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatroom_path(@chatroom)
    else
      redirect_to user_path(current_user)
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:title)
  end
end

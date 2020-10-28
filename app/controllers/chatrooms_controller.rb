class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
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

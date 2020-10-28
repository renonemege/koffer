class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.all

  end
end

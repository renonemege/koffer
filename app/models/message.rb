class Message < ApplicationRecord
  belongs_to :Chatroom
  belongs_to :User
end

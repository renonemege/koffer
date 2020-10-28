class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :user
  validates :content, presence: true
end

class Response < ApplicationRecord
  belongs_to :Survey
  belongs_to :User
  validates :content, presence: true
end

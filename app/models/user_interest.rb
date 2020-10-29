class UserInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :user
  validates :title, presence: true
end

class UserInterest < ApplicationRecord
  belongs_to :Interest
  belongs_to :User
  validates :title, presence: true
end

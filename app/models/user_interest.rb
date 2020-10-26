class UserInterest < ApplicationRecord
  belongs_to :Interest
  belongs_to :User
end

class UserOccupation < ApplicationRecord
  belongs_to :user
  belongs_to :occupation
  belongs_to :city
end

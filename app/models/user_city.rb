class UserCity < ApplicationRecord
  belongs_to :user
  belongs_to :city
  validates :title, presence: true
end

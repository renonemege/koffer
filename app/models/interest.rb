class Interest < ApplicationRecord
  has_many :user_interests
  validates :title, presence: true
end

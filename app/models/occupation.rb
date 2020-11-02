class Occupation < ApplicationRecord
  belongs_to :city
  has_many :users, through: :user_occupations
  has_many :user_occupations
end

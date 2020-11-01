class Occupation < ApplicationRecord
  belongs_to :city
  has_many :users
end

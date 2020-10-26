class City < ApplicationRecord
  has_many :reviews, as: :reviewable
  has_many :users, through: :user_cities
  validates :description, :country, :latitude, :longitude, :quality_of_life,
            :income, :living_cost, :traffic, :population, :currency, :weather, :score, presence: true
end

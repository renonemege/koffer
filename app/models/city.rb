class City < ApplicationRecord
  has_many :reviews, as: :reviewable
  has_many :users, through: :user_cities
  validates :title, :description, :country, :latitude, :longitude, :quality_of_life,
            :income, :living_cost, :traffic, :population, :currency, :weather, :score, presence: true

  geocoded_by :title
  after_validation :geocode, if: :will_save_change_to_title?
end

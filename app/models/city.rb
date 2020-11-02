class City < ApplicationRecord
  has_one_attached :photo
  has_many :reviews, as: :reviewable
  has_many :users, through: :user_cities
  has_many :occupations
  has_many :cost_of_livings
  has_many :city_details
  has_many :user_occupations
  validates :title, :description, :country, :latitude, :longitude, :quality_of_life,
            :income, :living_cost, :traffic, :population, :currency, :weather, :score, presence: true

  geocoded_by :title
  after_validation :geocode, if: :will_save_change_to_title?
  include PgSearch::Model

  pg_search_scope :search_by_title_and_country,
    against: [ :title,:country ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end


 # pg_search_scope :search_by_title_and_country, lambda { |title_and_country_part, query|
 #    {
 #      against: :title_and_country_part,
 #      query: query,
 #      using: {
 #        tsearch: { prefix: true } # <-- now `superman batm` will return something!
 #      }
 #    }
 #  }

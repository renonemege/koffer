class Survey < ApplicationRecord
  belongs_to :City
  belongs_to :User
  has_many :responses,
  validates :question, presence: true
end

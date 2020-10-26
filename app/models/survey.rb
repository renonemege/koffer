class Survey < ApplicationRecord
  belongs_to :city
  belongs_to :user
  has_many :responses
  validates :question, presence: true
end

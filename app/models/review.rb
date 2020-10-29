class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  validates :content, :stars, presence: true
end

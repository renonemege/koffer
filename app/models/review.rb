class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  validates :content, :stars, :title, presence: true
end

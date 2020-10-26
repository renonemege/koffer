class Survey < ApplicationRecord
  belongs_to :City
  belongs_to :User
end

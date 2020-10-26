class Response < ApplicationRecord
  belongs_to :Survey
  belongs_to :User
end

class WaitQueue < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  enum status: [:canceled, :waiting, :pending, :completed]
  
end

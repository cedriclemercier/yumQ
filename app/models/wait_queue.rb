class WaitQueue < ApplicationRecord
  belongs_to :restaurant

  enum status: [:canceled, :waiting, :pending, :completed]
  
end

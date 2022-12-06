class Review < ApplicationRecord
    belongs_to :user
    belongs_to :hotel
    MAX_RATING = 5
    validates :rating, numericality: { in: 0..MAX_RATING }
end

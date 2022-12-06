class Hotel < ApplicationRecord
    belongs_to :user
    has_many :reviews
    MAX_RATING = 5
    validates :rating, numericality: { in: 0..MAX_RATING }
end

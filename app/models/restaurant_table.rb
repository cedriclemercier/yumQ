class RestaurantTable < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :restaurant
end

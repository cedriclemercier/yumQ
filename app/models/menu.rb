class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items
  has_many :cart_items
end

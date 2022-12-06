class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end

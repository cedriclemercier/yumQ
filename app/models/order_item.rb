class OrderItem < ApplicationRecord
  belongs_to :menu
  belongs_to :order
end

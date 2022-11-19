class Order < ApplicationRecord
  belongs_to :user
  belongs_to :waitqueue

  has_many :order_items
end

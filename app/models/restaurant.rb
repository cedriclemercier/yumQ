class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :restaurant_table, dependent: :destroy
  has_many :wait_queue, dependent: :destroy
  has_many :staffs
  has_many :users, through: :staffs
  
  accepts_nested_attributes_for :user
end

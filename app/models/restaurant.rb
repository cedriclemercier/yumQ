class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menu, dependent: :destroy
end

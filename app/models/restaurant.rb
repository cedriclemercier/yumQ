class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :restaurant_table, dependent: :destroy
  has_many :wait_queue, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :users, through: :staffs
  
  accepts_nested_attributes_for :user

  has_one_attached :qr_code

  def self.search_name(search)
    with_attached_qr_code.
      references(:attachment_attachment).
      where(ActiveStorage::Blob.arel_table[:filename].matches("%#{search}%"))
  end
  
end

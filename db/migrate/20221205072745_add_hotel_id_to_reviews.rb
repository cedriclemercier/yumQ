class AddHotelIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :hotel_id, :integer
  end
end

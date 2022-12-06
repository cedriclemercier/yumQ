class AddPhotoUrlToRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :photo_url, :text
  end
end

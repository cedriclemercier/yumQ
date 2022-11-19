class FixRestaurantUserName < ActiveRecord::Migration[6.1]
  def change
    rename_column :restaurants, :owner_id, :user_id
  end
end

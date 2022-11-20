class AddTableNoToRestaurantTable < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurant_tables, :tableno, :integer, unique: true
  end
end

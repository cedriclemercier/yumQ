class CreateRestaurantTables < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurant_tables do |t|
      t.boolean :occupied, :default => false
      t.references :user, null: true, foreign_key: true
      t.references :restaurant, null: true, foreign_key: true
      t.datetime :release_at

      t.timestamps
    end
  end
end

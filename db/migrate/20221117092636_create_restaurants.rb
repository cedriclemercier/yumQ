class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.references :owner, index: true, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

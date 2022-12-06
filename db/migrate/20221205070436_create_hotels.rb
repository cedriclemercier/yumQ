class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :owner
      t.integer :rating

      t.timestamps
    end
  end
end

class CreateCart < ActiveRecord::Migration[6.1]
  def change
    create_table :cart do |t|
      t.decimal :total
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

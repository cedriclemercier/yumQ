class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.references :user, null: true, foreign_key: true
      t.references :wait_queue, null: false, foreign_key: true

      t.timestamps
    end
  end
end

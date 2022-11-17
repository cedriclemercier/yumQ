class CreateWaitQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :wait_queues do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :status
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

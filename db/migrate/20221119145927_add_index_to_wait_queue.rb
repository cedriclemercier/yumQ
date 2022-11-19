class AddIndexToWaitQueue < ActiveRecord::Migration[6.1]
  def change
    add_column :wait_queues, :user_id, :bigint
    add_index :wait_queues, [:user_id, :restaurant_id], unique: true
  end
end

class RemoveWaitQueueFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :wait_queue_id
  end
end

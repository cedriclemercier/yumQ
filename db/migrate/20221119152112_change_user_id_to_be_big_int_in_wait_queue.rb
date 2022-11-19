class ChangeUserIdToBeBigIntInWaitQueue < ActiveRecord::Migration[6.1]
  def change
    change_column :wait_queues, :user_id, 'bigint USING CAST(user_id as bigint)'
  end
end

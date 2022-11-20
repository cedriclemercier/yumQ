class ChangeFieldNameFromBooleanToEnum < ActiveRecord::Migration[6.1]
  def change
    change_column :wait_queues, :status, 'integer USING CAST(status as integer)' 
  end
end

class AddQueuetimeToRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :queuetime, :integer
  end
end

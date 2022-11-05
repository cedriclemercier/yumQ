class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :img
      t.string :name
      t.string :age
      t.string :occupation
      t.string :marital
      t.string :housing
      t.decimal :income
      t.string :sgoal
      t.string :lgoal
      t.string :questions
      t.string :tech
      t.string :other

      t.timestamps
    end
  end
end

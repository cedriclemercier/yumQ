class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.text :img
      t.text :name
      t.text :age
      t.text :occupation
      t.text :martial
      t.text :housing
      t.decimal :income
      t.text :sgoal
      t.text :lgoal
      t.text :questions
      t.text :tech
      t.text :other

      t.timestamps
    end
  end
end

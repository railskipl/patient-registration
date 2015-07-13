class CreatePrecriptions < ActiveRecord::Migration
  def change
    create_table :precriptions do |t|
      t.date :date_current
      t.text :precription
      t.integer :user_id
      t.integer :customer_id

      t.timestamps
    end
  end
end

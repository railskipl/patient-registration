class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :name
      t.text :description
      t.date :dob
      t.string :age
      t.string :avatar

      t.timestamps
    end
  end
end

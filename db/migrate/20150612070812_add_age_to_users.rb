class AddAgeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :age, :string
  end
end

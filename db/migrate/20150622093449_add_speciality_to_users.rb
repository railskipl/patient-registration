class AddSpecialityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :speciality_id, :integer
  end
end

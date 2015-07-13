class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string :speciality_name

      t.timestamps
    end
  end
end

class AddDescriptionToPrecriptions < ActiveRecord::Migration
  def change
    add_column :precriptions, :description, :text
  end
end

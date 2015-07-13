class AddUpdappointmentToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :updappointment, :string
  end
end

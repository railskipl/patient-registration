class AddFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :doc_id, :integer
    add_column :customers, :reception_id, :integer
  end
end

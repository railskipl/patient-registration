class CreateCustomerAttachments < ActiveRecord::Migration
  def change
    create_table :customer_attachments do |t|
      t.string :avatar
      t.integer :customer_id
      t.integer :user_id

      t.timestamps
    end
  end
end

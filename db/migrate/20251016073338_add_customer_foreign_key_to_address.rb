class AddCustomerForeignKeyToAddress < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :addresses, :customers, column: :customer_id
  end
end

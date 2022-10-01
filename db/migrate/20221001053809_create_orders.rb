class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
      
      t.integer :customer_id, null: false
      t.string :shipping_postal_code, null: false
      t.string :shipping_name, null: false
      t.string :shipping_address, null: false
      t.integer :postage, null: false
      t.integer :payment, null: false, default: 0
      t.integer :billing_amount, null: false
      t.integer :status, null: false, default: 0
    end
  end
end

class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :sku
      t.text :shipping_address
      t.date :latest_shipping_date
      t.string :order_status
      t.string :customer_name
      t.string :warehouse_status

      t.timestamps null: false
    end
  end
end

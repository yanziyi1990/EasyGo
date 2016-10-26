class CreateWarehouseUnits < ActiveRecord::Migration
  def change
    create_table :warehouse_units do |t|
      t.string :name
      t.text :sku
      t.integer :count
      t.string :status

      t.timestamps null: false
    end
  end
end

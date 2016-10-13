class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :product_name
      t.text :image_url1
      t.text :image_url2
      t.text :image_url3
      t.text :product_description
      t.string :category
      t.string :color
      t.string :vendor

      t.timestamps null: false
    end
  end
end

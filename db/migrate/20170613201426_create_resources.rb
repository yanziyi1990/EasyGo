class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :data

      t.timestamps null: false
    end
  end
end

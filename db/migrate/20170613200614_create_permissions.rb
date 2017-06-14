class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.references :resource, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end

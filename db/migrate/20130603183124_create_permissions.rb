class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :role
      t.references :post

      t.timestamps
    end
    add_index :permissions, :role_id
    add_index :permissions, :post_id
  end
end

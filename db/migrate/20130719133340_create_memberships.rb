class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :role
      t.references :user
      t.references :site

      t.timestamps
    end
    add_index :memberships, :role_id
    add_index :memberships, :user_id
    add_index :memberships, :site_id
  end
end

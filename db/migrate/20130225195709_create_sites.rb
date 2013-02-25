class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :subdomain
      t.string :layout
      t.references :company

      t.timestamps
    end
    add_index :sites, :company_id
  end
end

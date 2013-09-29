class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :details
      t.references :site
      t.references :user
      t.integer :company_id

      t.timestamps
    end
    add_index :issues, :site_id
    add_index :issues, :user_id
  end
end

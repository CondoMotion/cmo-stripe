class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.string :slug
      t.references :site

      t.timestamps
    end
    add_index :pages, :site_id
    add_index :pages, :slug
  end
end

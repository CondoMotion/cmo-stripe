class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.references :post
      t.references :site

      t.timestamps
    end
    add_index :postings, :post_id
    add_index :postings, :site_id
  end
end

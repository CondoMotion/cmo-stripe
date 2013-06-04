class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachment
      t.belongs_to :attachable, polymorphic: true

      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
  end
end

class AddSendEmailToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :send_email, :boolean
  end
end

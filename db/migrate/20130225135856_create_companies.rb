class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :phone
      t.string :website
      t.string :logo
      t.integer :owner_id

      t.timestamps
    end
  end
end

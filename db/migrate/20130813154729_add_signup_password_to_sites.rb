class AddSignupPasswordToSites < ActiveRecord::Migration
  def change
    add_column :sites, :signup_password, :string
  end
end

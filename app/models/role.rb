class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  has_many :permissions
	has_many :posts, through: :permissions
  has_many :memberships

  scope :site_roles, -> { where("name = ? OR name = ? or name = ? or name = ?", "manager", "admin", "trustee", "resident") }
  
  scopify

  def select_label
    name.titleize
  end

end

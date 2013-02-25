class Company < ActiveRecord::Base
	belongs_to :owner, class_name: "User"
	has_many :users
	has_many :sites

  attr_accessible :logo, :name, :owner_id, :phone, :website, :remote_logo_url
  mount_uploader :logo, LogoUploader
end

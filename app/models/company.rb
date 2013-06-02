class Company < ActiveRecord::Base
	belongs_to :owner, class_name: "User"
	has_many :users, dependent: :destroy
	has_many :sites, dependent: :destroy
	has_one :address, as: :addressable 

	accepts_nested_attributes_for :address

  attr_accessible :logo, :name, :owner_id, :phone, :website, :remote_logo_url, :address_attributes
  mount_uploader :logo, LogoUploader
end

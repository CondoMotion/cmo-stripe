class Document < ActiveRecord::Base
	has_one :post, as: :postable
	has_one :attachment, as: :attachable
  has_many :sites, through: :posts
  
  accepts_nested_attributes_for :post, :attachment

  attr_accessible :post_attributes, :attachment_attributes
end
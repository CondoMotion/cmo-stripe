class Document < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	has_one :attachment, as: :attachable, dependent: :destroy
  has_many :postings, through: :post
  has_many :sites, through: :postings
  
  accepts_nested_attributes_for :post, :attachment

  attr_accessible :post_attributes, :attachment_attributes
end
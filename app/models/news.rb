class News < ActiveRecord::Base
	has_one :post, as: :postable, dependent: :destroy
	has_one :attachment, as: :attachable
  has_many :postings, through: :post
  has_many :sites, through: :postings
  
  accepts_nested_attributes_for :post, :attachment

  attr_accessible :content, :post_attributes, :attachment_attributes
end
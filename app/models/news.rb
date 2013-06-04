class News < ActiveRecord::Base
	has_one :post, as: :postable
	has_one :attachment, as: :attachable
  
  accepts_nested_attributes_for :post, :attachment

  attr_accessible :content, :post_attributes, :attachment_attributes
end
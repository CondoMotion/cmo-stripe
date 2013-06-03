class Document < ActiveRecord::Base
	has_one :post, as: :postable
  
  accepts_nested_attributes_for :post

  attr_accessible :post_attributes
end
class News < ActiveRecord::Base
	has_one :post, as: :postable
  
  accepts_nested_attributes_for :post

  attr_accessible :content, :post_attributes
end
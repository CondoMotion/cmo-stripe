class Posting < ActiveRecord::Base
  belongs_to :post
  belongs_to :site
  # attr_accessible :title, :body
end

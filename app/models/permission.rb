class Permission < ActiveRecord::Base
  belongs_to :role
  belongs_to :post
  # attr_accessible :title, :body
end

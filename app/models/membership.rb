class Membership < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
  belongs_to :site
  # attr_accessible :title, :body
end

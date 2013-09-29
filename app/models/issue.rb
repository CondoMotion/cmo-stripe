class Issue < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  attr_accessible :company_id, :details, :title
end

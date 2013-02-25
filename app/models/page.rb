class Page < ActiveRecord::Base
  belongs_to :site
  attr_accessible :content, :name, :site_id

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :site_id

  extend FriendlyId
  friendly_id :name, use: :scoped, scope: :site
  acts_as_list scope: :site
end

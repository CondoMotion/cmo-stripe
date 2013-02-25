class Site < ActiveRecord::Base
  belongs_to :company
  has_many :pages

  attr_accessible :layout, :name, :subdomain
  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain
  before_save :set_subdomain

  def set_subdomain
  	if Site.find_by_subdomain(self.subdomain.parameterize)
  		return false
  	else
  		self.subdomain = self.subdomain.parameterize
  	end
  end
end
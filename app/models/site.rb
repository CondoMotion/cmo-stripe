class Site < ActiveRecord::Base
  belongs_to :company
  has_one :address, as: :addressable
  has_many :postings
  has_many :posts, through: :postings

  has_many :documents, through: :posts, source: :postable, source_type: "Document"
  has_many :newses, through: :posts, source: :postable, source_type: "News"

  accepts_nested_attributes_for :address

  attr_accessible :layout, :name, :subdomain, :address_attributes

  before_validation :set_subdomain
  after_save :update_stripe
  after_destroy :update_stripe

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :subdomain

  def set_subdomain
		self.subdomain = self.subdomain.parameterize
  end

  def update_stripe
  	company.owner.update_stripe
  end
end
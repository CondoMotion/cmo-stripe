class Address < ActiveRecord::Base
  attr_accessible :address1, :address2, :addressable_id, :addressable_type, :city, :state, :zip

  belongs_to :addressable, polymorphic: true

  validates_presence_of :address1, :city, :state, :zip
end

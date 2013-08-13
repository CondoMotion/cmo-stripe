class Post < ActiveRecord::Base
  attr_accessible :attachment_label, :title, :user_id, :postable_type, :postable_id, :role_ids, :site_ids

  has_many :permissions
  has_many :roles, through: :permissions
  has_many :postings
  has_many :sites, through: :postings
  belongs_to :postable, polymorphic: true
  belongs_to :user
  belongs_to :company

  def visible_to
    users = []
    sites.each do |site|
      site.memberships.each do |membership|
        if role_ids.include? membership.role.id
          users.push membership.user.email unless users.include? membership.user.email
        end
      end
    end
    users
  end
end

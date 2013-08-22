class Post < ActiveRecord::Base
  attr_accessible :attachment_label, :title, :user_id, :postable_type, :postable_id, :role_ids, :site_ids

  has_many :permissions
  has_many :roles, through: :permissions
  has_many :postings
  has_many :sites, through: :postings
  has_many :memberships, through: :sites
  belongs_to :postable, polymorphic: true
  belongs_to :user
  belongs_to :company

  validates :title, :role_ids, :site_ids, presence: true

  def visible_to_emails
    emails = []
    roles = self.roles.map(&:id)
    self.memberships.includes(:user).each do |membership|
      if roles.include? membership.role_id
        emails.push membership.user.email
      end
    end
    emails.uniq
  end

  def manager_emails
    emails = []
    sites.each do |site|
      site.managers.each do |membership|
        emails.push membership.email
      end
    end
    emails.uniq
  end
end

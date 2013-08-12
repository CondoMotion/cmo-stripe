class User < ActiveRecord::Base
  rolify

  has_one :owned_company, class_name: "Company", foreign_key: :owner_id, dependent: :destroy
  belongs_to :company
  has_many :memberships, dependent: :destroy
  has_many :sites, through: :memberships

  accepts_nested_attributes_for :owned_company
  accepts_nested_attributes_for :memberships, allow_destroy: true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :trackable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable

  validates :name, presence: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :stripe_token, :coupon, :owned_company_attributes, :memberships_attributes
  attr_accessor :stripe_token, :coupon
  after_create :add_company
  before_save :update_stripe 
  before_destroy :cancel_subscription

  def manager
    self.memberships.joins(:role).where(roles: { name: "manager" }).length > 0
  end

  def manages(site_id)
    self.memberships.joins(:role).where(site_id: site_id).where(roles: { name: "manager" }).length > 0
  end

  def managed_sites
    if self == self.company.owner
      company.sites.all
    else
      Site.find(self.memberships.joins(:role).where(roles: { name: "manager" }).map(&:site_id))
    end
  end

  def member(site_id)
    self.memberships.where(site_id: site_id).length > 0
  end

  def member_sites
    if self == self.company.owner
      company.sites.all
    else
      sites.all
    end
  end

  def has_post_role(post_role_ids, post_site_ids)
    i = 0
    self.memberships.each do |m|
      if post_role_ids.include?(m.role.id) && post_site_ids.include?(m.site.id)
        i += 1
      end
    end
    i > 0
  end

  def post_site_member(post_site_ids)
    (post_site_ids & self.site_ids).length > 0
  end

  def post_site_manager(post_site_ids)
    i = 0
    self.memberships.each do |m|
      if post_site_ids.include?(m.site.id) && m.role.name == "manager"
        i += 1
      end
    end
    i > 0
  end

  def quantity 
    if self.company.nil?
      1
    else
      self.company.sites.length == 0 ? 1 : self.company.sites.length
    end
  end

  def add_company
    if self.owned_company
      self.company = self.owned_company
      self.save
    end
  end

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      customer.update_subscription(:plan => role.name)
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def free?
    %w[admin manager resident trustee].include? roles.first.name
  end
  
  def update_stripe
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    return if free?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      options = {:email => email, :description => name, :card => stripe_token, :plan => roles.first.name, :coupon => (coupon unless coupon.blank?), :quantity => quantity}.reject{ |k,v| v.nil? }
      customer = Stripe::Customer.create(options)
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = name
      customer.update_subscription(plan: roles.first.name, quantity: quantity)
      customer.save
    end
    self.last_4_digits = customer.active_card.last4
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end
  
  def cancel_subscription
    unless customer_id.nil?
      customer = Stripe::Customer.retrieve(customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end
  
end

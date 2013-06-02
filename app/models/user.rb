class User < ActiveRecord::Base
  rolify

  has_one :owned_company, class_name: "Company", foreign_key: :owner_id, dependent: :destroy
  belongs_to :company

  accepts_nested_attributes_for :owned_company
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :stripe_token, :coupon, :owned_company_attributes
  attr_accessor :stripe_token, :coupon
  before_save :update_stripe 
  before_save :add_company
  before_destroy :cancel_subscription

  def quantity 
    company.sites.length
  end

  def add_company
    if self.owned_company
      self.company = self.owned_company
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
    %w[admin manager resident].include? roles.first.name
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

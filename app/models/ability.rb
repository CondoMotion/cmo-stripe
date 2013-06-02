class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif ((user.has_role? :monthly) | (user.has_role? :annual))
      can :manage, User
      can :edit, Company, :owner_id => user.id
      can :create, Company, :owner_id => user.id
      can :manage, Site, :company_id => user.company.id
    elsif user.has_role? :manager
      # can :create, User, :comapny_id => user.company.id
      can :edit, Site, :company_id => user.company.id
      can :read, Site, :company_id => user.company.id
      can :edit, Company, :id => user.company.id
      can :manage, User
    else

    end
  end
end
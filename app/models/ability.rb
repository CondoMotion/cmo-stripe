class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif ((user.has_role? :monthly) | (user.has_role? :annual))
      can :manage, User do |u|
        u.company == user.owned_company && u != user
      end
      can :edit, Company, :owner_id => user.id
      can :create, Company, :owner_id => user.id
      can :manage, Site, :company_id => user.company.id
      can :manage, Page do |p|
        p.site.company == user.company
      end
    elsif user.has_role? :manager
      # can :create, User, :comapny_id => user.company.id
      can :read, User, :company_id => user.company.id
      can :manage, Site, :company_id => user.company.id
      can :manage, Page do |p|
        p.site.company == user.company
      end
      can :destroy, User do |u|
        u.company == user.company && u != user && user.company.owner != u
      end
    else

    end
  end
end
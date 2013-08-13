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
      can :manage, Post, :company_id => user.company.id
    elsif ((user.has_role? :manager) | (user.has_role? :resident))
      # can :create, User, :comapny_id => user.company.id
      can :read, Site, :company_id => user.company.id
      can :read, Post do |post|
        post.company.owner == user || (user.post_site_member(post.site_ids) && user.has_post_role(post.role_ids, post.site_ids))
      end
      can :edit, Post do |post|
        post.company.owner == user || user.post_site_manager(post.site_ids)
      end
      if user.manager
        can :read, User
        can :edit, Company, :id => user.company.id
        can :edit, Site do |site|
          site.company_id == user.company.id && user.manages(site.id)
        end
        can :create, Post
      end
    else

    end
  end
end
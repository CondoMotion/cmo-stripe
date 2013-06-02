class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_company
  before_filter :set_site
  before_filter :set_sites

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url(subdomain: "www")
  end

  def after_sign_in_path_for(resource)
    case current_user.roles.first.name
      when 'admin'
        users_path
      else
        show_company_path
    end
  end

  def set_site
    if request.subdomain.present? && request.subdomain != "www"
      @site = Site.find_by_subdomain(request.subdomain)
    end
  end

  def set_company
    if current_user
      if current_user.company
        @company = current_user.company
      elsif current_user.owned_company
        @company = current_user.owned_company
      end
    elsif @site
      @company = @site.company
    end
  end

  def set_sites
    @sites = @company.sites.reject(&:new_record?) if @company
  end
  
end
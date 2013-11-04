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
        news_index_path
    end
  end

  def set_site
    if request.subdomain.present? && request.subdomain != "www"
      @site = Site.find_by_subdomain(request.subdomain)
    end
  end

  def set_company
    if current_user
      @company = current_user.company
    elsif @site
      @company = @site.company
    end
  end

  def set_sites
    if @company 
      if current_user == @company.owner
        @sites = @company.sites.order(:name).reject(&:new_record?) if @company
      else
        @sites = current_user.sites.order(:name)
      end
    end
  end
  
  # NOTE: with root:false, the json output from ouer serializers will 
  #      not contain  the root identifier object. This keeps things 
  #      compatible with what backbone expects.
  def default_serializer_options
    {root: false}
  end

end

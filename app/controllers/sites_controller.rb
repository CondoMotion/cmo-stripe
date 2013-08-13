class SitesController < ApplicationController
  before_filter :authenticate_user!, except: :show
  # GET /sites
  # GET /sites.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = current_user.company.sites.build
    authorize! :create, @site

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = current_user.company.sites.find_by_subdomain!(request.subdomain)
    authorize! :edit, @site
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = current_user.company.sites.build(params[:site])
    authorize! :create, @site

    respond_to do |format|
      if @site.save
        format.html { redirect_to root_url(subdomain: @site.subdomain), notice: 'Property was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = current_user.company.sites.find(params[:id])
    authorize! :edit, @site

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to root_url(subdomain: @site.subdomain), notice: 'Property was successfully updated.' }
        format.json { head :no_content }
      else
        @pages = @site.pages
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = current_user.company.sites.find(params[:id])
    authorize! :destroy, @site
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Property was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end

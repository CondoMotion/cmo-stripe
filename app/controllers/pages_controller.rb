class PagesController < ApplicationController
  # GET /pages/1
  # GET /pages/1.json
  def show
    @site = Site.find_by_subdomain!(request.subdomain)
    @page = @site.pages.find(params[:id])
    @pages = @site.pages.order(:position)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    authorize! :edit, @page
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    authorize! :create, @page

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_site_path(@page.site), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])
    authorize! :update, @page

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to edit_site_path(@page.site), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    authorize! :destroy, @page
    @page.destroy

    respond_to do |format|
      format.html { redirect_to edit_site_path(@page.site), notice: 'Page was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def sort
    params[:page].each_with_index do |id, index|
      Page.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end

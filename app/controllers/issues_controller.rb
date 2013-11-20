class IssuesController < ApplicationController

  respond_to :json

  def index
    respond_with Issue.all
  end

  def show
    respond_with Issue.find(params[:id])
  end

  def create
    site = Site.find(params[:site_id])
    respond_with site.issues.create(params[:issue])
    #respond_with Issue.create(params[:issue])
  end

  def update
    respond_with Issue.update(params[:id], params[:issue])
  end

  def destroy
    respond_with Issue.destroy(params[:id])
  end

end


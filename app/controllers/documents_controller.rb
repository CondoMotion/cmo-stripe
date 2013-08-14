class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    if params[:site] && !Site.find(params[:site]).nil?
      @posts = Site.find(params[:site].to_i).posts.order("created_at DESC").where(postable_type: "Document")
    else
      @posts = @company.posts.order("created_at DESC").where(postable_type: "Document")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new
    @document.build_post(role_ids: Role.site_roles.map(&:id))
    @document.build_attachment

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    @document.build_attachment if @document.attachment.nil?
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])
    @document.post.user = current_user
    @document.post.company = current_user.company

    respond_to do |format|
      if @document.save
        @document.post.visible_to_emails.each do |email|
          PostMailer.delay.new_post(@document.post, email)
        end
        format.html { redirect_to documents_url, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to documents_url, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully deleted.' }
      format.js   { render nothing: true }
      format.json { head :no_content }
    end
  end
end

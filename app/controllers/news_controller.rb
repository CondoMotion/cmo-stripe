class NewsController < ApplicationController
  # GET /news
  # GET /news.json
  def index
    if params[:site] && !Site.find(params[:site]).nil?
      @posts = Site.find(params[:site].to_i).posts.where(postable_type: "News")
    else
      @posts = Post.order("created_at DESC").where(postable_type: "News")
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new
    @news.build_post(role_ids: Role.where("name = ? or name = ? or name = ?", "resident", "admin", "manager").map(&:id))
    @news.build_attachment

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
    @news.build_attachment if @news.attachment.nil?
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])
    @news.post.user = current_user

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end

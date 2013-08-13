class SignupsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:signup_password] == @site.signup_password
      @user = User.new(params[:user])
      @user.add_role("resident")
      @user.company = @site.company
      m = @user.memberships.new
      m.site = Site.find(params[:site_id])
      m.role = Role.find_by_name("resident")

      if @user.save
        sign_in @user
        redirect_to news_index_url(subdomain: "www"), notice: "You have signed up successfully!"
      else
        @password = params[:signup_password]
        render "new"
      end
    else
      redirect_to site_signup_path, flash: { error: "Incorrect site password" }
    end
  end
end
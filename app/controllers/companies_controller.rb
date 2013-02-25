class CompaniesController < ApplicationController
	before_filter :authenticate_user!

	def show
		@company = current_user.company
	end

  def edit
  	@company = current_user.owned_company
  	authorize! :edit, @company
  	if current_user.has_role? :manager
  		redirect_to current_user.company
  	end
  end

  def create
  	@company = current_user.build_owned_company(params[:company])
  	authorize! :create, @company
  	if @company.save 
  		redirect_to edit_company_path, notice: "Company created successfully!"
  	else
  		render "edit"
  	end
  end

  def update
  	@company = current_user.owned_company
  	authorize! :edit, @company

  	if @company.update_attributes(params[:company])
  		redirect_to @company, notice: "Company information updated successfully!"
  	else
  		render "edit"
  	end
  end

  def users
  	@users = current_user.company.users
  	authorize! :index, User
  end

end
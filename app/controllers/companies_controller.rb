class CompaniesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def show
    if current_user
      @company = current_user.company
    else
      @company = Company.find(params[:id])
    end
  end

  def edit
    @company = current_user.company
    authorize! :edit, @company
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
    @company = current_user.company
    authorize! :edit, @company

    if @company.update_attributes(params[:company])
      if params[:redirect_to] == "company"
        redirect_to @company, notice: "Company information updated successfully!"
      else
        redirect_to '/users/edit/company', notice: "Company information updated successfully!"
      end
    else
      render "edit"
    end
  end

  def users
    @users = current_user.company.users
    authorize! :index, User
  end

end
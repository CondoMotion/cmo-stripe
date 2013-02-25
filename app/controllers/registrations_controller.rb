class RegistrationsController < Devise::RegistrationsController
  
  def company_user_registration
    @user = User.new(params[:user])
    @user.add_role(params[:plan].downcase)
    @user.password = "changeme"
    @user.password_confirmation = "changeme"
    @user.company = current_user.owned_company

    if @user.save
      redirect_to company_managers_path, notice: "Manager successfully added!"
    else
      @users = current_user.company.users.with_role(:manager)
      render "companies/managers"
    end
  end

  def new
    @plan = params[:plan]

    if @plan && ENV["ROLES"].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to pricing_path, :notice => 'Please select a subscription plan below.'
    end
  end

  def update_plan
    @user = current_user
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    if @user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      render :edit
    end
  end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end

protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

private

  def build_resource(*args)
    super
    if params[:plan]
      resource.add_role(params[:plan])
    end
  end

end

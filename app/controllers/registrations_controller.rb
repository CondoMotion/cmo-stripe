class RegistrationsController < Devise::RegistrationsController

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user])
    else
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user), notice: "Your account was successfully updated!"
    else
      render "edit"
    end
  end

  def new
    @plan = params[:plan]

    if @plan && ENV["ROLES"].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to pricing_path, :notice => 'Please select a subscription plan.'
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
      redirect_to '/users/edit/billing', :notice => 'Updated card.'
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

  def needs_password?(user, params)
    user.email != params[:user][:email] || !params[:user][:password].nil?
  end

end

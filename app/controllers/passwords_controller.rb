class PasswordsController < ApplicationController
  skip_before_action :authenticate!, only: %i[edit update]

  def update
    if resource.update resource_params
      flash[:success] = I18n.t 'flash.save.success'

      redirect_to %i[new session]
    else
      flash.now[:error] = I18n.t 'flash.save.failure'

      render :edit, turbolinks: true
    end
  end

  private

  def resource
    @resource ||= User.find_by password_recovery_token: params[:token] if params[:token].present?
  end

  def resource_params
    params.require(:user).permit(:password, :password_confirmation).merge(password_recovery_token: nil)
  end

  def authorize_resource
    authorize resource, policy_class: PasswordPolicy
  end
end

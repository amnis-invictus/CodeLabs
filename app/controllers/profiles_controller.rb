class ProfilesController < ApplicationController
  def update
    flash.now[:success] = I18n.t 'profile.update.success' if resource.update resource_params

    render :show
  end

  alias_method :resource, :current_user

  private
  def resource_params
    params.require(:user).permit(:username, :name, :password, :password_confirmation, :avatar, :skills, :city, :institution)
  end
end

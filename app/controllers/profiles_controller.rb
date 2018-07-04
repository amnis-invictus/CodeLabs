class ProfilesController < ApplicationController
  def update
    resource.update resource_params

    render :show
  end

  alias_method :resource, :current_user

  private
  def resource_params
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar, skills: [])
  end
end

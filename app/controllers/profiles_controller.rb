class ProfilesController < ApplicationController
  def update
    if resource.update resource_params
      flash.now[:success] = I18n.t 'flash.save.success'
    else
      flash.now[:error] = I18n.t 'flash.save.failure'
    end

    render :show, turbolinks: true
  end

  private

  alias_method :resource, :current_user

  def resource_params
    params.require(:user).permit(:username, :name, :password, :password_confirmation, :skills, :city, :institution)
  end
end

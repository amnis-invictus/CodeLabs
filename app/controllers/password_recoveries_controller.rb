class PasswordRecoveriesController < ApplicationController
  attr_reader :resource

  skip_before_action :authenticate!, only: %i[new create]

  def create
    if verify_recaptcha
      resource.save

      render :create, turbolinks: true
    else
      render :new, turbolinks: true
    end
  end

  private

  def resource_params
    params.require(:password_recovery).permit(:email)
  end

  def build_resource
    @resource = PasswordRecovery.new resource_params
  end

  def initialize_resource
    @resource = PasswordRecovery.new
  end
end

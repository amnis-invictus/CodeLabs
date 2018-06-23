class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: %i(new create)

  def create
    render :new and return unless resource.save

    session[:auth_token] = resource.auth_token.id

    redirect_to :profile
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def initialize_resource
    @resource = Session.new
  end

  def build_resource
    @resource = Session.new resource_params
  end
end

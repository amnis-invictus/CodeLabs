class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: %i(new create)

  def create
    render :new and return unless resource.save

    cookies.encrypted[:auth_token] = resource.auth_token.id

    redirect_to session[:redirect] || resource.redirect

    session[:redirect] = nil
  end

  def destroy
    resource.destroy

    cookies.encrypted[:auth_token] = nil

    redirect_to :root
  end

  private
  def resource
    @resource ||= Session.new auth_token: AuthToken.find(cookies.encrypted[:auth_token])
  end

  def resource_params
    params.require(:session).permit(:email, :password, :redirect)
  end

  def initialize_resource
    @resource = Session.new
  end

  def build_resource
    @resource = Session.new resource_params
  end
end

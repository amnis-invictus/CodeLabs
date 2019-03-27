class ConfirmationRequestsController < ApplicationController
  def create
    if resource.save
      flash[:success] = I18n.t 'flash.save.success'
    else
      flash[:error] = I18n.t 'flash.save.failure'
    end

    redirect_to :profile
  end

  private

  attr_reader :resource

  def collection
    @collection ||= ConfirmationRequest.includes(:user).page(params[:page])
  end

  def build_resource
    @resource = ConfirmationRequest.new user: current_user
  end
end

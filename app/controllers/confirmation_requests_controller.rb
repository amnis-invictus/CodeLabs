class ConfirmationRequestsController < ApplicationController
  def create
    if resource.save
      flash[:success] = 'Success'
    else
      flash[:error] = 'Error'
    end

    redirect_to :profile
  end

  private

  attr_reader :resource

  def collection
    @collection ||= ConfirmationRequest.page params[:page]
  end

  def build_resource
    @resource = ConfirmationRequest.new user: current_user
  end
end

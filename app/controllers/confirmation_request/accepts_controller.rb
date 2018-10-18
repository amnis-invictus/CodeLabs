class ConfirmationRequest::AcceptsController < ApplicationController
  def create
    flash[:error] = 'Validation errors' unless resource.save

    redirect_back fallback_location: :confirmation_requests, allow_other_host: false
  end

  private
  attr_reader :resource

  def parent
    @parent ||= ConfirmationRequest.find params[:confirmation_request_id]
  end

  def build_resource
    @resource = ConfirmationRequest::Accept.new parent
  end
end

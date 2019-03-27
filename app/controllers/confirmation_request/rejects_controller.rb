class ConfirmationRequest::RejectsController < ApplicationController
  def create
    flash[:error] = I18n.t 'flash.save.failure' unless resource.save

    redirect_back fallback_location: :confirmation_requests, allow_other_host: false
  end

  private

  attr_reader :resource

  def parent
    @parent ||= ConfirmationRequest.find params[:confirmation_request_id]
  end

  def build_resource
    @resource = ConfirmationRequest::Reject.new parent
  end
end

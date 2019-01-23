class Invite::RejectsController < ApplicationController
  def create
    flash[:error] = 'Validation errors' unless resource.save

    redirect_back fallback_location: :received_invites, allow_other_host: false
  end

  private

  attr_reader :resource

  def parent
    @parent ||= Invite.find params[:invite_id]
  end

  def build_resource
    @resource = Invite::Reject.new parent
  end
end

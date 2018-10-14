class ReceivedInvitesController < ApplicationController
  skip_before_action :authorize_collection

  private
  def collection
    @collection ||= current_user.received_invites.order(id: :desc).page(params[:page])
  end
end

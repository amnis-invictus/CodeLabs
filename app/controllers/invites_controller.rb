class InvitesController < ApplicationController
  def create
    render :new and return unless resource.save

    flash[:success] = 'Invite created'

    redirect_to parent
  end

  private

  attr_reader :resource

  def collection
    @collection ||= parent.invites.includes(:sender, :receiver).order(id: :desc).page(params[:page])
  end

  def parent
    @parent ||= Group.find params[:group_id]
  end

  def resource_params
    params.require(:invite).permit(:receiver_id).merge(sender: current_user)
  end

  def initialize_resource
    @resource = parent.invites.new
  end

  def build_resource
    @resource = parent.invites.new resource_params
  end
end

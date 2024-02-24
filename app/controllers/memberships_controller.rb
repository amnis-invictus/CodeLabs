class MembershipsController < ApplicationController
  def create
    if resource.save
      redirect_to resource.membershipable
    else
      render :new, turbolinks: true
    end
  end

  def update
    resource.update resource_params

    redirect_back fallback_location: resource.membershipable
  end

  def destroy
    resource.destroy

    redirect_back fallback_location: resource.membershipable
  end

  private

  def collection
    @collection ||= ((defined?(parent) && parent) || current_user).pending_memberships.order(id: :desc).page(params[:page])
  end

  def initialize_resource
    @resource = parent.pending_memberships.new
  end

  def resource
    @resource ||= Membership.find params[:id]
  end
end

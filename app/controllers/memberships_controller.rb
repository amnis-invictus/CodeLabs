class MembershipsController < ApplicationController
  def destroy
    resource.destroy

    redirect_to resource.group
  end

  private

  def resource
    @resource ||= Membership.new resource_params
  end

  def resource_params
    { group: Group.find(params[:group_id]), user: User.find(params[:id]) }
  end
end

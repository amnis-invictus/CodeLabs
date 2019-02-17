class MembershipsController < ApplicationController
  def create
    resource.save

    redirect_to resource.group
  end

  def destroy
    resource.destroy

    redirect_to resource.group
  end

  private

  def parent
    @parent ||= Group.find params[:group_id]
  end

  def resource
    @resource ||= Membership.find params[:id]
  end

  def resource_params
    params.require(:membership).permit(:user_id, :type).merge(group: parent)
  end

  def build_resource
    @resource = MembershipFactory.build current_user, resource_params
  end
end

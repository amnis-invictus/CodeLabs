class GroupMembershipsController < MembershipsController
  private

  def parent
    @parent ||= Group.find params[:group_id] if params[:group_id]
  end

  def resource_params
    { state: :accepted }
  end

  def create_resource_params
    params.require(:group_membership).permit(:user_id, :type).merge(group: parent, role: :user)
  end

  def policy record
    policy = Pundit::PolicyFinder.new(record).policy!

    policy == GroupMembershipPolicy ? GroupMembershipPolicy.new(current_user, record, parent: parent) : super
  end

  def build_resource
    @resource = GroupMembershipFactory.build current_user, create_resource_params
  end
end

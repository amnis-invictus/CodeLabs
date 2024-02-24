class ContestMembershipsController < MembershipsController
  private

  def parent
    @parent ||= Contest.find params[:contest_id] if params[:contest_id]
  end

  def resource_params
    { state: :accepted }
  end

  def create_resource_params
    params.require(:contest_membership).permit(:user_id, :type).merge(contest: parent)
  end

  def policy record
    policy = Pundit::PolicyFinder.new(record).policy!

    policy == ContestMembershipPolicy ? ContestMembershipPolicy.new(current_user, record, parent: parent) : super
  end

  def build_resource
    @resource = ContestMembershipFactory.build current_user, create_resource_params
  end
end

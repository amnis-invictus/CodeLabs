class GroupMembershipFactory < MembershipFactory
  def build
    GroupMembership.new user: user, state: state, membershipable: @params[:group]
  end

  private

  def state
    return unless @params[:group]

    case @params[:type]
    when 'invite' then :invited
    when 'request'
      case @params[:group].visibility
      when 'moderated' then :requested
      when 'public'    then :accepted
      end
    end
  end
end

class ContestMembershipFactory < MembershipFactory
  def build
    ContestMembership.new user: user, state: state, membershipable: @params[:contest]
  end

  private

  def state
    return unless @params[:contest]

    case @params[:type]
    when 'invite' then :invited
    when 'request'
      case @params[:contest].visibility
      when 'moderated' then :requested
      when 'public'    then :accepted
      end
    end
  end
end

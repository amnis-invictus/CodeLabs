class MembershipFactory < ApplicationFactory
  def initialize current_user, params
    @current_user, @params = current_user, params
  end

  def build
    Membership.new @params.slice(:user_id, :group).merge(state: state)
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

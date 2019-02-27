class MembershipFactory < ApplicationFactory
  def initialize current_user, params
    @current_user, @params = current_user, params
  end

  def build
    Membership.new @params.slice(:group).merge(user: user, state: state)
  end

  private

  def user
    case @params[:type]
    when 'invite'
      User.find_by id: @params[:user_id]
    when 'request'
      @current_user
    end
  end

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

class MembershipFactory < ApplicationFactory
  def initialize current_user, params
    @current_user, @params = current_user, params
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
end

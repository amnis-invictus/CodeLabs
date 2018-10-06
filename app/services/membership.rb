class Membership
  attr_reader :group, :user

  delegate :owner, to: :group, prefix: true, allow_nil: true

  def initialize params={}
    @group = params[:group]

    @user = params[:user]
  end

  def destroy
    group.users.destroy user
  end
end

class Invite::Accept
  attr_reader :invite

  delegate :sender, :receiver, :pending?, to: :invite, prefix: true

  def initialize invite
    @invite = invite
  end

  def save
    Invite.transaction do
      invite.group_users << invite.receiver

      invite.update status: :accepted
    end
  end
end

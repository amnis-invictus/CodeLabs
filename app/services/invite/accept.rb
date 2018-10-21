class Invite::Accept
  attr_reader :invite

  delegate :sender, :receiver, :pending?, to: :invite, prefix: true

  def initialize invite
    @invite = invite
  end

  def save
    invite.update(status: :accepted).tap do |result|
      invite.group_users << invite.receiver if result
    end
  end
end

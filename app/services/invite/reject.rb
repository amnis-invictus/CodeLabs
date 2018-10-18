class Invite::Reject
  attr_reader :invite

  delegate :sender, :receiver, :pending?, to: :invite, prefix: true

  def initialize invite
    @invite = invite
  end

  def save
    invite.update status: :rejected
  end
end

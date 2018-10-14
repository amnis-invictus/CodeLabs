class InviteDecorator < Draper::Decorator
  delegate_all

  decorates_associations :sender, :receiver

  delegate :name, to: :sender, prefix: true

  delegate :name, to: :receiver, prefix: true, allow_nil: true
end

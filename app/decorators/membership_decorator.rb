class MembershipDecorator < Draper::Decorator
  delegate_all

  decorates_associations :user, :group

  delegate :name, to: :user, prefix: true, allow_nil: true

  delegate :name, to: :group, prefix: true, allow_nil: true
end

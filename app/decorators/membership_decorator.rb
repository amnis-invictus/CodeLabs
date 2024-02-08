class MembershipDecorator < Draper::Decorator
  delegate_all

  decorates_associations :user, :membershipable

  delegate :name, to: :user, prefix: true, allow_nil: true

  delegate :name, to: :membershipable, prefix: true, allow_nil: true
end

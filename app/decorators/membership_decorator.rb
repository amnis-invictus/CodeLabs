class MembershipDecorator < Draper::Decorator
  delegate_all

  decorates_associations :user, :contest

  delegate :name, to: :user, prefix: true, allow_nil: true

  delegate :name, to: :contest, prefix: true, allow_nil: true
end

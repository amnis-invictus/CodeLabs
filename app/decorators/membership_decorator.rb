class MembershipDecorator < Draper::Decorator
  delegate_all

  decorates_association :user

  delegate :name, to: :user, prefix: true, allow_nil: true
end

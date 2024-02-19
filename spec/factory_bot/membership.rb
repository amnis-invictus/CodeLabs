FactoryBot.define do
  factory :membership do
    state { :accepted }

    trait :for_group do
      association :user, :confirmed
      association :membershipable, :private, factory: :group
      state { :accepted }
      role { :owner }
      type { 'GroupMembership' }
    end
  end
end

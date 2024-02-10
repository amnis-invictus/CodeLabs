FactoryBot.define do
  factory :membership do
    state { :accepted }

    trait :for_group do
      association :user, :confirmed
      association(:membershipable, factory: :group)
      state { :accepted }
      role { :owner }
      type { 'Group' }
    end
  end
end

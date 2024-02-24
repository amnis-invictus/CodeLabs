FactoryBot.define do
  factory :membership do
    state { :accepted }

    trait :for_group do
      type { 'GroupMembership' }
    end
  end
end

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    username { 'John.Doe' }
    email { 'john.doe@codelabs.test' }
    password { 'P@ssw0rd!' }
    password_confirmation { 'P@ssw0rd!' }
    city { 'Chicago' }
    institution { 'New York Regional College' }
    skills { 'Chicago, Doe, Regional' }

    trait :admin do
      name { 'John Doe Admin' }
      username { 'admin.John.Doe' }
      email { 'admin.john.doe@codelabs.test' }
      roles { %i[confirmed moderator administrator] }
    end
  end
end

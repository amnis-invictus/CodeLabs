FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:username) { "John.Doe.#{ _1 }" }
    sequence(:email) { "john.doe.#{ _1 }@codelabs.test" }
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

    trait :confirmed do
      name { 'John Doe Confirmed' }
      username { 'conf.John.Doe' }
      email { 'conf.john.doe@codelabs.test' }
      roles { %i[confirmed] }
    end
  end
end

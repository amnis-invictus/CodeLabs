FactoryBot.define do
  factory :group do
    name { 'Hufflepuff' }
    description { 'Hufflepuff was one of the four Houses of Hogwarts School of Witchcraft and Wizardry.' }
    visibility { 'public' }

    trait :private do
      name { 'Slytherin' }
      description { 'Slytherin was one of the four Houses at Hogwarts School of Witchcraft and Wizardry.' }
      visibility { 'private' }
    end

    trait :moderated do
      name { 'Gryffindor' }
      description { 'Gryffindor was one of the four Houses at Hogwarts School of Witchcraft and Wizardry.' }
      visibility { 'moderated' }
    end
  end
end

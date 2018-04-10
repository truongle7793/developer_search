FactoryBot.define do
  factory :developer, class: Developer do
    email { Faker::Internet.email }
  end

  factory :programming_language, class: ProgrammingLanguage do
    name 'Ruby'
  end

  factory :developer_programming_language, class: DeveloperProgrammingLanguage do
    developer
    programming_language
  end

  factory :language, class: Language do
    code 'en'
  end

  factory :developer_language, class: DeveloperLanguage do
    developer
    language
  end
end
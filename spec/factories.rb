FactoryBot.define do

  factory :developer, class: Developer do
    email 'mrabc@gmail.com'
  end

  factory :programming_language, class: ProgrammingLanguage do
    name 'Ruby'
  end

  factory :developer_programming_language, class: DeveloperProgrammingLanguage do
  end

  factory :language, class: Language do
    code 'fr'
  end

  factory :developer_language, class: DeveloperLanguage do
  end

end
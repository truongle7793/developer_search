namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate developers test data'
  task generate_data: :environment do

    100.times do
      email = Faker::Internet.email
      Developer.find_or_create_by(email: email)
    end

    create_programming_languages

    languages_array = %w[en vn de fr ja nl el]
    languages_array.each do |language|
      Language.find_or_create_by(code: language)
    end

    Developer.all.each do |developer|
      programming_language = ProgrammingLanguage.order('RANDOM()').first
      DeveloperProgrammingLanguage.find_or_create_by(developer_id: developer.id, programming_language_id: programming_language.id)
      languages_array.sample(rand(1..3)).each do |lang|
        language = Language.where(code: lang).first
        DeveloperLanguage.find_or_create_by(developer_id: developer.id, language_id: language.id)
      end
    end

  end

  def create_programming_languages
    ProgrammingLanguage.find_or_create_by(name: 'Ruby')
    ProgrammingLanguage.find_or_create_by(name: 'PHP')
    20.times do
      ProgrammingLanguage.find_or_create_by(name: Faker::ProgrammingLanguage.name)
    end
  end

end

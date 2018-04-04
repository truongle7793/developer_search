namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate developers test data'
  task generate_data: :environment do

    100.times do
      email = Faker::Internet.email
      Developer.find_or_create_by(email: email)
    end

    create_default_data
    20.times do
      ProgrammingLanguage.find_or_create_by(name: Faker::ProgrammingLanguage.name)
    end

    language_code_array = %w[en vn de fr ja nl el]
    language_code_array.each do |language|
      Language.find_or_create_by(code: language)
    end

    Developer.all.each do |developer|
      programming_language = ProgrammingLanguage.order('RANDOM()').first
      DeveloperProgrammingLanguage.find_or_create_by(developer_id: developer.id, programming_language_id: programming_language.id)
      # link developer with languages
      language_array = language_code_array.sample(rand(1..3))
      language_array.each do |lang|
        language = Language.where(code: lang).first
        DeveloperLanguage.find_or_create_by(developer_id: developer.id, language_id: language.id)
      end
    end

  end

  def create_default_data
    ProgrammingLanguage.find_or_create_by(name: 'Ruby')
    ProgrammingLanguage.find_or_create_by(name: 'PHP')
  end

end

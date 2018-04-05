namespace :dev do
  require 'factory_bot_rails'
  require 'faker'

  desc 'Generate developers test data'
  task generate_data: :environment do

    create_programming_languages

    %w[en vn de fr ja nl el].each do |language|
      Language.find_or_create_by(code: language)
    end

    programming_languages = ProgrammingLanguage.all
    languages = Language.all
    100.times do
      FactoryBot.create(:developer,
                        programming_languages: programming_languages.sample(Random.rand(1..2)),
                        languages: languages.sample(Random.rand(0..3)))
    end
  end

  def create_programming_languages
    # Make sure that there are Ruby and PHP developer language
    ProgrammingLanguage.find_or_create_by(name: 'Ruby')
    ProgrammingLanguage.find_or_create_by(name: 'PHP')
    20.times do
      ProgrammingLanguage.find_or_create_by(name: Faker::ProgrammingLanguage.name)
    end
  end

end

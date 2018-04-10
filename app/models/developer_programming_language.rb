class DeveloperProgrammingLanguage < ApplicationRecord
  belongs_to :developer, inverse_of: :developer_programming_languages
  belongs_to :programming_language, inverse_of: :developer_programming_languages
end

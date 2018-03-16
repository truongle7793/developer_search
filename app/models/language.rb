class Language < ApplicationRecord
  has_many :developers, through: :developer_languages
  has_many :developer_languages, dependent: :destroy
end

class Developer < ApplicationRecord
  has_many :developer_languages, dependent: :destroy
  has_many :languages, through: :developer_languages, inverse_of: :developers

  has_many :developer_programming_languages, dependent: :destroy
  has_many :programming_languages, through: :developer_programming_languages, inverse_of: :developers

  validates :email, presence: true, uniqueness: true
end

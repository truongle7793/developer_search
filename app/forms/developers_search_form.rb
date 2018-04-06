class DevelopersSearchForm
  include Virtus.model
  include ActiveModel::Model

  attribute :language, String
  attribute :programming_language, String

  def search
    return Developer.none if [language, programming_language].all?(&:blank?)

    query = Developer.includes(:developer_languages, :languages, :developer_programming_languages, :programming_languages)
    query = query.where(languages: { code: language }) if language.present?
    query = query.where(programming_languages: { name: programming_language }) if programming_language.present?
    query = query.order('developers.created_at desc')
    query
  end
end
class DevelopersSearchForm
  include Virtus.model
  include ActiveModel::Model
  include ActiveRecord::Sanitization::ClassMethods

  attribute :language, String
  attribute :programming_language, String

  def search
    check_language = language.present?
    check_programming_language = programming_language.present?
    return Developer.none if !check_language && !check_programming_language

    query = Developer.includes(:developer_languages, :languages, :developer_programming_languages, :programming_languages)
    query = query.where(languages: { code: language }) if check_language
    query = query.where(programming_languages: { name: programming_language }) if check_programming_language
    query = query.order('developers.created_at desc')
    query
  end
end
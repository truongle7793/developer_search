class DevelopersSearchForm
  include Virtus.model
  include ActiveModel::Model
  include ActiveRecord::Sanitization::ClassMethods

  attribute :email, String
  attribute :language, String
  attribute :programming_language, String

  def search
    if !email.present? && !language.present? && !programming_language.present?
      Developer.none
    else
      query = Developer.includes(:developer_languages, :languages, :developer_programming_languages, :programming_languages)
      query = query.where('developers.email like :email_search_string', email_search_string: "%#{sanitize_sql_like(email)}%") if email.present?
      query = query.where(languages: { code: language }) if language.present?
      query = query.where(programming_languages: { name: programming_language }) if programming_language.present?
      query = query.order('developers.created_at desc')
      query
    end
  end
end
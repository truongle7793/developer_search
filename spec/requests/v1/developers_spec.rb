require 'rails_helper'
require 'spec_helper'
require 'support/shared_context_for_api.rb'

describe 'Api::V1::DevelopersController' do
  include_context 'api'

  describe 'GET /api/v1/developers/:developer_id' do
    before do
      @developer = create(:developer,
                          languages: [FactoryBot.create(:language)],
                          programming_languages: [FactoryBot.create(:programming_language)])
    end

    context 'when the developer exists' do
      let(:expected_response) do
        @developer.as_json(
          include: {
            languages: {
              only: :code
            },
            programming_languages: {
              only: :name
            }
          },
          except: %i[created_at updated_at],
          status: :ok
        ).deep_symbolize_keys
      end

      before do
        get "/api/v1/developers/#{@developer.id}"
      end

      it_behaves_like 'http_status_code_200_with_json'
    end

    context 'when the developer does not exist' do
      before do
        get '/api/v1/developers/9999'
      end

      it_behaves_like 'http_status_code_404'
    end
  end
end
require 'rails_helper'
RSpec.describe DevelopersSearchForm do
  describe '#search' do
    before do
      test_developer_one = create(:developer, email: 'tester@gmail.com')
      test_developer_two = create(:developer, email: 'leluongtruong7793@gmail.com')
      programming_language_one = create(:programming_language, name: 'PHP')
      programming_language_two = create(:programming_language, name: 'Ruby')
      create(:programming_language, name: 'Python')
      language_one = create(:language, code: 'en')
      language_two = create(:language, code: 'vn')
      create(:developer_programming_language, developer_id: test_developer_one.id, programming_language_id: programming_language_one.id)
      create(:developer_programming_language, developer_id: test_developer_two.id, programming_language_id: programming_language_two.id)
      create(:developer_language, developer_id: test_developer_one.id, language_id: language_one.id)
      create(:developer_language, developer_id: test_developer_one.id, language_id: language_two.id)
      create(:developer_language, developer_id: test_developer_two.id, language_id: language_two.id)
    end

    context 'Test searching with no search fields provided' do
      it 'returns empty developer list' do
        form = DevelopersSearchForm.new
        expect(form.search.size).to eq(0)
      end
    end

    context 'Test searching for developer using existing Programming Language' do
      it 'Return list of one developer that have existing programming language' do
        form = DevelopersSearchForm.new(programming_language: 'PHP')
        expect(form.search.size).to eq(1)
      end
    end

    context 'Test searching for developer using non-existing Programming Language' do
      it 'Return empty developer list' do
        form = DevelopersSearchForm.new(programming_language: 'Java')
        expect(form.search.size).to eq(0)
      end
    end

    context 'Test searching for developer using existing Programming Language but do not belong to any developer' do
      it 'Return empty developer list' do
        form = DevelopersSearchForm.new(programming_language: 'Python')
        expect(form.search.size).to eq(0)
      end
    end

    context 'Test searching for developer using Language field' do
      it 'Return list of two developer that know English' do
        form = DevelopersSearchForm.new(language: 'en')
        expect(form.search.size).to eq(1)
      end

      it 'Return list of two developer that know Vietnamese' do
        form = DevelopersSearchForm.new(language: 'vn')
        expect(form.search.size).to eq(2)
      end
    end

    context 'Test searching for developer using Email' do
      it 'Search for developer Email that exists in database' do
        form = DevelopersSearchForm.new(email: 'leluongtruong7793@gmail.com')
        expect(form.search.size).to eq(1)
      end

      it 'Search for developer Email that do not exist in database' do
        form = DevelopersSearchForm.new(email: 'leluongtruong112233@gmail.com')
        expect(form.search.size).to eq(0)
      end
    end

    context 'Test searching for developer using multiple fields' do
      it 'Successfully search for developer that have Ruby Programming Language and knowing Vietnamese' do
        form = DevelopersSearchForm.new(programming_language: 'Ruby', language: 'vn')
        expect(form.search.size).to eq(1)
      end

      it 'Search for developer that have Ruby Programming Language and knowing English' do
        form = DevelopersSearchForm.new(programming_language: 'Ruby', language: 'en')
        expect(form.search.size).to eq(0)
      end

      it 'Successfully search for developer that have PHP Programming Language and knowing English' do
        form = DevelopersSearchForm.new(programming_language: 'PHP', language: 'en')
        expect(form.search.size).to eq(1)
      end
    end

  end
end
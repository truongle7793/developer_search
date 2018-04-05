require 'rails_helper'
RSpec.describe DevelopersSearchForm do
  describe 'Search Developers Function' do
    before do
      create(:programming_language, name: 'Python')
      language_one = create(:language, code: 'en')
      language_two = create(:language, code: 'vn')
      create(:developer, email: 'tester@gmail.com', programming_languages: [create(:programming_language, name: 'PHP')], languages: [language_one, language_two])
      create(:developer, email: 'leluongtruong7793@gmail.com', programming_languages: [create(:programming_language, name: 'Ruby')], languages: [language_two])
    end

    context 'Search with no search fields provided' do
      it 'Show none records' do
        form = DevelopersSearchForm.new
        expect(form.search.size).to eq(0)
      end
    end

    context 'Search with existing Programming Language' do
      it 'Show matched records' do
        form = DevelopersSearchForm.new(programming_language: 'PHP')
        expect(form.search.size).to eq(1)
      end
    end

    context 'Search with existing non-existing Programming Language' do
      it 'Show none record of developer' do
        form = DevelopersSearchForm.new(programming_language: 'Java')
        expect(form.search.size).to eq(0)
      end
    end

    context 'Search with existing Programming Language but it do not belong to any developer' do
      it 'Show none record of developer' do
        form = DevelopersSearchForm.new(programming_language: 'Python')
        expect(form.search.size).to eq(0)
      end
    end

    context 'Search with Language' do
      it 'Show list of developers that know the language' do
        form = DevelopersSearchForm.new(language: 'en')
        expect(form.search.size).to eq(1)
      end
    end

    context 'Search with programming language and language' do
      it 'Showed matched records when there are developer record match the condition' do
        form = DevelopersSearchForm.new(programming_language: 'Ruby', language: 'vn')
        expect(form.search.size).to eq(1)
      end
    end

  end
end
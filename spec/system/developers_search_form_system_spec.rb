require 'rails_helper'
describe 'Search for developer' do
  before do
    create(:programming_language, name: 'Python')
    language_one = create(:language, code: 'en')
    language_two = create(:language, code: 'vn')
    create(:developer, email: 'tester123@gmail.com', programming_languages: [create(:programming_language, name: 'PHP')], languages: [language_one, language_two])
    create(:developer, email: 'leluongtruong7793@gmail.com', programming_languages: [create(:programming_language, name: 'Ruby')], languages: [language_two])
  end

  it 'Search using programming language field' do
    visit developers_path
    fill_in 'developers_search_form_programming_language', with: 'Ruby'
    click_on 'Search'
    expect(page).to have_content('leluongtruong7793@gmail.com')
  end

  it 'Search using multiple fields' do
    visit developers_path
    fill_in 'developers_search_form_programming_language', with: 'Ruby'
    fill_in 'developers_search_form_language', with: 'vn'
    click_on 'Search'
    expect(page).to have_content('leluongtruong7793@gmail.com')
    fill_in 'developers_search_form_programming_language', with: 'PHP'
    fill_in 'developers_search_form_language', with: 'en'
    click_on 'Search'
    expect(page).to have_content('tester123@gmail.com')
    sleep 2
  end
end
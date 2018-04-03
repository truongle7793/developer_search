require 'rails_helper'
describe 'Search for developer' do
  before do
    test_developer_one = create(:developer, email: 'tester123@gmail.com')
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

  it 'Search developers with empty form fields' do
    visit developers_path
    click_on 'Search'
    expect(page).to have_content('No Data Found')
    sleep 2
  end

  it 'Search using email field' do
    visit developers_path
    fill_in 'developers_search_form_email', with: 'leluongtruong7793@gmail.com'
    click_on 'Search'
    expect(page).to have_content('leluongtruong7793@gmail.com')
    expect(page).to have_content('Ruby')
  end

  it 'Search using language field' do
    visit developers_path
    fill_in 'developers_search_form_language', with: 'en'
    click_on 'Search'
    expect(page).to have_content('tester123@gmail.com')
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
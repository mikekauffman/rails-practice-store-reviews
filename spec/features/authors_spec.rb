require 'spec_helper'

feature 'User can add an author' do
  before do
    DatabaseCleaner.clean
    User.create!(
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: true
    )
    User.create!(
      email: 'not-admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: false
    )
  end

  scenario 'add author' do
    visit '/login'

    fill_in 'session[email]', with: 'admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    visit '/authors/new'
    fill_in 'author[first_name]', with: 'Thomas'
    fill_in 'author[last_name]', with: 'Killjoy'
    fill_in 'author[bio]', with: 'He is an old grey haired man who writes books.'
    click_on 'Save Author'
    expect(page).to have_content 'Author Thomas Killjoy successfully added'
    expect(page).to have_content 'He is an old grey haired man who writes books.'
    expect(current_path).to eq '/authors'
  end

  scenario 'guests and non-admins cannot add new authors' do
    visit '/authors/new'
    expect(page).to have_content 'Access Denied'

    click_on 'Login'

    fill_in 'session[email]', with: 'not-admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    visit '/authors/new'

    expect(page).to have_content 'Access Denied'
  end
end
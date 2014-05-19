require 'spec_helper'

feature 'adding a publisher' do
  before do
    User.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true
    )
    User.create!(
      email: 'not-admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )

    visit '/login'

    fill_in 'session[email]', with: 'admin@example.com'
    fill_in 'session[password]', with: 'password'
    click_on 'Login'
  end
  scenario 'user can add a new publisher' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: 'Penguin Books'
    fill_in 'publisher[city]', with: 'New York'
    click_on 'Save Publisher'
    expect(page).to have_content 'Publisher Penguin Books successfully added'
    expect(current_path).to eq '/publishers/new'
  end

  scenario 'user cannot add a publisher with blank fields' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: ''
    fill_in 'publisher[city]', with: ''
    click_on 'Save Publisher'
    expect(page).to have_content 'Name and City are required fields'
    expect(current_path).to eq '/publishers/new'
  end

  scenario 'user cannot add a publisher with only spaces in fields' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: '         '
    fill_in 'publisher[city]', with: '             '
    click_on 'Save Publisher'
    expect(page).to have_content 'Name and City are required fields'
    expect(current_path).to eq '/publishers/new'
  end

  scenario 'non-admins cannot add new publishers' do
    visit '/login'

    fill_in 'session[email]', with: 'not-admin@example.com'
    fill_in 'session[password]', with: 'password'
    click_on 'Login'

    visit '/publishers/new'

    expect(page).to have_content 'Access Denied'
    expect(current_path).to eq '/'
  end
end
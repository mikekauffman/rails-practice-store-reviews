require 'spec_helper'

feature 'User Registration' do
  scenario 'User can create an account' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(page).to have_content 'Welcome, user@example.com'
  end
end
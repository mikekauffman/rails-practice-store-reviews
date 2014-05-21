require 'spec_helper'

feature 'User Registration' do
  scenario 'User can create an account and a welcome email is sent' do
    visit '/'

    emails_sent = ActionMailer::Base.deliveries.length

    click_link 'Register'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(page).to have_content 'Welcome, user@example.com'
    expect(page).to_not have_link 'Add Publisher'
    expect(ActionMailer::Base.deliveries.length).to eq (emails_sent + 1)
  end

  scenario 'Users see an error message if they register with an invalid email' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]', with: 'invaliduser@example,com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'invalid email/password'
  end

  scenario 'User email shows to indicate logged in status after navigating away from login page' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    click_on 'Register'

    expect(page).to have_content 'Welcome, user@example.com'
    visit '/'
    expect(page).to have_content 'Welcome, user@example.com'

    click_link 'Logout'

    expect(current_url).to eq 'http://www.example.com/'
    expect(page).to have_no_content 'Welcome, user@example.com'
  end
end

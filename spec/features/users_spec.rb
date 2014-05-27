require 'spec_helper'

feature 'User Registration' do
  scenario 'User can create an account and a welcome email is sent' do
    visit '/'

    emails_sent = ActionMailer::Base.deliveries.length

    click_link 'Register'

    fill_in 'user[email]', with: 'actionmailer@example.com'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'
    click_button 'Register'

    expect(page).to have_content 'Welcome, actionmailer@example.com'
    expect(page).to_not have_link 'Add Publisher'
    expect(ActionMailer::Base.deliveries.length).to eq (emails_sent + 1)

    expect(page).to_not have_content 'Login'
    expect(page).to_not have_content 'Register'
  end

  scenario 'Users see an error message if they register with an invalid email' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]', with: 'invaliduserexample,com'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'
    click_button 'Register'

    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email is invalid'
  end

  context 'user logs in' do
    before do
      visit '/'
      click_link 'Register'

      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password1'
      fill_in 'user[password_confirmation]', with: 'password1'
      click_button 'Register'
    end

    scenario 'User email shows to indicate logged in status after navigating away from login page' do
      visit '/'

      expect(page).to have_content 'Welcome, user@example.com'

      click_link 'Logout'

      expect(current_url).to eq 'http://www.example.com/'
      expect(page).to have_no_content 'Welcome, user@example.com'
    end

    scenario 'Registered user can login without password confirmation' do
      click_link 'Logout'
      click_link 'Login'
      fill_in 'session[email]', with: 'user@example.com'
      fill_in 'session[password]', with: 'password1'
      click_button 'Login'
      expect(page).to have_content 'Welcome, user@example.com'
    end
  end
end

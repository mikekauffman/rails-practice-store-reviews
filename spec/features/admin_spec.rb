require 'spec_helper'

feature 'Admin users' do
  scenario 'Admin visits a users page and logs in' do
    User.create!(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      is_admin: true
    )

    visit '/login'

    fill_in 'session[email]', with: 'admin@example.com'
    fill_in 'session[password]', with: 'password'
    click_on 'Login'

    expect(page).to have_content 'Welcome admin@example.com'
  end

  scenario 'Non Admin cannot login' do

    visit '/login'

    fill_in 'session[email]', with: 'test@example.com'
    fill_in 'session[password]', with: 'password'
    click_on 'Login'

    expect(page).to have_content 'invalid username/password'

  end
end
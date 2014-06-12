require 'spec_helper'

feature 'Admin users' do
  before do
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
  scenario 'Admin visits a users page and logs in' do

    visit '/login'

    fill_in 'session[email]', with: 'admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    expect(page).to have_content 'Welcome, admin@example.com'
  end

  scenario 'Non Admin cannot login' do

    visit '/login'

    fill_in 'session[email]', with: 'test@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    expect(page).to have_content 'invalid email/password'

  end

  scenario 'Admins see a link to add a publisher, author, and product' do
    visit '/'
    within('nav') do
      expect(page).to_not have_link 'Add Publisher'
      expect(page).to_not have_link 'Add Author'
      expect(page).to_not have_link 'Add Product'
    end

    click_link 'Login'

    fill_in 'session[email]', with: 'not-admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    expect(page).to have_content 'Welcome, not-admin@example.com'

    within('nav') do
      expect(page).to_not have_link 'Add Publisher'
      expect(page).to_not have_link 'Add Author'
      expect(page).to_not have_link 'Add Product'
    end

    click_link 'Logout'

    click_link 'Login'

    fill_in 'session[email]', with: 'admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    expect(page).to have_content 'Welcome, admin@example.com'

    within('nav') do
      expect(page).to have_link 'Add Publisher'
      expect(page).to have_link 'Add Author'
      expect(page).to have_link 'Add Product'
    end
  end

  scenario 'Non admins cannot see a link to add a publisher, author, or product' do
    visit '/'
    expect(page).to_not have_link 'Add Publisher'
    expect(page).to_not have_link 'Add Author'
    expect(page).to_not have_link 'Add Product'

    click_link 'Login'

    fill_in 'session[email]', with: 'not-admin@example.com'
    fill_in 'session[password]', with: 'password1'
    click_button 'Login'

    expect(page).to have_content 'Welcome, not-admin@example.com'

    within('nav') do
      expect(page).to_not have_link 'Add Publisher'
      expect(page).to_not have_link 'Add Author'
      expect(page).to_not have_link 'Add Product'
    end
  end
end
require 'spec_helper'

feature 'User Registration' do
  before do
    DatabaseCleaner.clean
  end
  scenario 'User can create an account, a welcome email is sent and they are logged in' do
    visit '/'

    emails_sent = ActionMailer::Base.deliveries.length

    click_link 'Register'

    fill_in 'user[email]', with: 'bob@example.com'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'
    click_button 'Register'

    expect(page).to have_content 'Welcome, bob@example.com'
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

  scenario 'App sends password reset email' do
    visit '/'
    click_link 'Register'

    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'password1'
    fill_in 'user[password_confirmation]', with: 'password1'
    click_button 'Register'
    click_link 'Logout'

    emails_sent = ActionMailer::Base.deliveries.length

    click_link 'Login'

    click_link 'Forgot password?'

    fill_in 'email', with: 'user@example.com'
    click_button 'Reset my password'


    expect(ActionMailer::Base.deliveries.length).to eq (emails_sent + 1)
    expect(page).to have_content 'Please check your email to reset your password.'

    found_user = User.find_by(email: "user@example.com")
    expect(found_user.reset_token).to_not be_nil

    email_message = ActionMailer::Base.deliveries.last.body.raw_source
    @doc = Nokogiri::HTML(email_message)
    result = @doc.xpath("//html//body//p//a//@href")[0].value

    visit result

    fill_in 'user[password]', with: 'foo'
    fill_in 'user[password]', with: 'foo'
    click_button 'Update password'

    expect(page).to have_content("Password must be at least 8-12 characters with 1 number")

    fill_in 'user[password]', with: 'foo'
    fill_in 'user[password]', with: 'foo'
    click_button 'Update password'

    expect(page).to have_content("Password must be at least 8-12 characters with 1 number")

    fill_in 'user[password]', with: 'password2'
    fill_in 'user[password_confirmation]', with: 'password2'
    click_button 'Update password'
    expect(page).to have_content("Please use your new password to login.")
    fill_in 'session[email]', with: 'user@example.com'
    fill_in 'session[password]', with: 'password2'
    click_button 'Login'
    expect(page).to have_content 'Welcome, user@example.com'
  end

end

require 'spec_helper'

describe UserMailer do
  let :user do
    User.new(email: "new-user@example.com", password: "password1", password_confirmation: "password1")
  end
  let(:welcome_message) { UserMailer.welcome_email(user) }

  it 'comes from the proper email address' do
    expect(welcome_message.from).to eq ["notifications@g2-store.com"]
  end

  it 'goes to the right email address' do
    expect(welcome_message.to).to eq ["new-user@example.com"]
  end

  it 'has the proper subject' do
    expect(welcome_message.subject).to eq 'Thank you for signing up!'
  end

  it 'has a welcome message in the body' do
    expect(welcome_message.body).to have_content 'Thanks for joining and have a great day!'
  end
end
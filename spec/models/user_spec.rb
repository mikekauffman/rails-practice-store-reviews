require 'spec_helper'

describe User do
  it 'Creates admin and non-admin users' do
    admin = User.new(
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: true
    )
    admin.save!
    expect(User.last).to eq admin
    user = User.new(
      email: 'user@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: false
    )
    user.save!
    expect(admin.admin?).to eq true
    expect(user.admin?).to eq false
  end

  it 'Only accepts valid email addresses' do
    user = User.new(
      email: 'user1@example,com',
      password: 'password1'
    )
    expect(user.valid?).to eq false
  end

  it 'Email cannot be blank' do
    user = User.new(
      email: '',
      password: 'password1'
    )
    expect(user.valid?).to eq false
  end

  it 'Only accepts valid password' do
    user = User.new(
        email: 'user1@example.com',
        password: 'password'
    )
    expect(user.valid?).to eq false
  end

  it 'Accepts password that starts with a number' do
    user = User.new(
        email: 'user1@example.com',
        password: '1password',
        password_confirmation: '1password'
    )
    expect(user.valid?).to eq true
  end

  it 'Only accepts passwords with more than 8 characters' do
    user = User.new(
        email: 'user1@example.com',
        password: '1pass',
        password_confirmation: '1pass'
    )
    expect(user.valid?).to eq false
  end

  it 'Requires a password confirmation' do
    user = User.new(
        email: 'user1@example.com',
        password: '1password',
        password_confirmation: '1password',
    )
    expect(user.valid?).to eq true
  end
end



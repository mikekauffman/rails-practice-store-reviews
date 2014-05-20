require 'spec_helper'

describe User do
  it 'Creates admin and non-admin users' do
    admin = User.new(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true
    )
    admin.save!
    expect(User.last).to eq admin
    user = User.new(
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
    user.save!
    expect(admin.admin?).to eq true
    expect(user.admin?).to eq false
  end

  it 'Only accepts valid email addresses' do
    user = User.new(
      email: 'user1@example,com',
      password: 'password'
    )
    expect(user.valid?).to eq false
  end

  it 'Email cannot be blank' do
    user = User.new(
      email: '',
      password: 'password'
    )
    expect(user.valid?).to eq false
  end
end
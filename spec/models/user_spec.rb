require 'spec_helper'

describe User do
  it 'Create an admin' do
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
end
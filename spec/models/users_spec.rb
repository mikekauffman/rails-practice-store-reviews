require 'spec_helper'

describe User do
  it 'Create an admin' do
    admin = User.new(
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      is_admin: true
    )
    admin.save!

    expect(User.last).to eq admin
  end
end
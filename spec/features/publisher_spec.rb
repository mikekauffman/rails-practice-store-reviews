require 'spec_helper'

feature 'User can add a publisher' do
  scenario 'add publisher' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: 'Penguin Books'
    fill_in 'publisher[city]', with: 'New York'
    click_on 'Save Publisher'
    expect(page).to have_content 'Publisher Penguin Books successfully added'
    expect(current_path).to eq '/publishers/new'
  end
end
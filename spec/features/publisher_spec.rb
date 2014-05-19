require 'spec_helper'

feature 'adding a publisher' do
  scenario 'user can add a new publisher' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: 'Penguin Books'
    fill_in 'publisher[city]', with: 'New York'
    click_on 'Save Publisher'
    expect(page).to have_content 'Publisher Penguin Books successfully added'
    expect(current_path).to eq '/publishers/new'
  end

  scenario 'user cannot add a publisher with blank fields' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: ''
    fill_in 'publisher[city]', with: ''
    click_on 'Save Publisher'
    expect(page).to have_content 'Name and City are required fields'
    expect(current_path).to eq '/publishers/new'
  end

  scenario 'user cannot add a publisher with only spaces in fields' do
    visit '/publishers/new'
    fill_in 'publisher[name]', with: '         '
    fill_in 'publisher[city]', with: '             '
    click_on 'Save Publisher'
    expect(page).to have_content 'Name and City are required fields'
    expect(current_path).to eq '/publishers/new'
  end
end
require 'spec_helper'

feature 'User can add an author' do
  scenario 'add author' do
    visit '/authors/new'
    fill_in 'author[first_name]', with: 'Thomas'
    fill_in 'author[last_name]', with: 'Killjoy'
    fill_in 'author[bio]', with: 'He is an old grey haired man who writes books.'
    click_on 'Save Author'
    expect(page).to have_content 'Author Thomas Killjoy successfully added'
    expect(current_path).to eq '/authors/new'
  end
end
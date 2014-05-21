require 'spec_helper'

feature 'shopping for products' do
  scenario 'user can see products on the homepage and view a show page for each one' do
    author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')
    visit '/products/new'

    fill_in 'product[name]', with: "Making Bricks With 3D-Printers"
    fill_in 'product[hardcover_price]', with: 19.99
    fill_in 'product[softcover_price]', with: 9.99
    fill_in 'product[description]', with: "This is the description"
    fill_in 'product[image_url]', with: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg'
    fill_in 'product[published_date]', with: "1/1/2014"
    select 'Arthur Radcliffe', from: 'Author'
    select 'Arthur Books', from: 'Publisher'
    click_on 'Save Product'

    expect(page).to have_content 'Product successfully added'
    expect(current_path).to eq '/'

    expect(page).to have_content "Radcliffe"
    expect(page).to have_content "Arthur Books"
    expect(page).to have_content "(Jan 1, 2014)"
    expect(page).to have_content "19.99"
    expect(page).to have_content "(Softcover)"
    page.has_css?(:text => 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg', :visible => true)

    ##click_link "Making Bricks With 3D-Printers"
    #
    #expect(page).to have_content "Making Bricks With 3D-Printers"
    #expect(page).to have_content "Arthur Books"
    #expect(page).to have_content "(Jan 1, 2014)"
    #expect(page).to have_content "9.99"
    #expect(page).to have_content "(Softcover)"
    #page.has_css?(:text => 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg', :visible => true)
  end
end

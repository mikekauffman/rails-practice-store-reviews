require 'spec_helper'

feature 'shopping for products' do
  scenario 'user can see a product on the homepage' do
    visit '/products/new'

    fill_in 'product[name]', with: "Making Bricks With 3D-Printers"
    fill_in 'product[hardcover_price]', with: 19.99
    fill_in 'product[softcover_price]', with: 9.99
    fill_in 'product[description]', with: "This is the description"
    fill_in 'product[image_url]', with: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg'
    fill_in 'product[published_date]', with: "1/1/2014"
    click_on 'Save Product'

    expect(page).to have_content "Making Bricks With 3D-Printers"
    expect(page).to have_content "(Jan 1, 2014)"
    expect(page).to have_content "19.99"
    expect(page).to have_content "9.99"
    expect(page).to have_content "(Hardcover)"
    expect(page).to have_content "(Softcover)"
    page.has_css?(:text => 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg', :visible => true)
  end
end

require 'spec_helper'

feature 'shopping for products' do
  scenario 'user can see a product on the homepage' do
    visit '/products'

    expect(page).to have_content "Making Bricks With 3D-Printers"
    expect(page).to have_content "For the poorest programmer"
    expect(page).to have_content "2014-01-01"
    expect(page).to have_content "19.99"
    expect(page).to have_content "9.99"
    expect(page).to have_content "(Hardcover)"
    expect(page).to have_content "(Softcover)"
    expect(page).to have_css "img"
  end
end
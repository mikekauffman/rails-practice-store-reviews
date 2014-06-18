require 'spec_helper'

feature "Shopping Cart" do

  scenario 'user can see items in the shopping cart' do
    product = create_product
    visit product_path(product)
    click_on 'Add To Cart'
    expect(page).to have_content 'My Cart'
    expect(page).to have_content 'Great Gatsby'
  end
end
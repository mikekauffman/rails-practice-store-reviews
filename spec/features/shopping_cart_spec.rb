require 'spec_helper'

feature "Shopping Cart" do

  scenario 'guest user and logged in user can see items in the shopping cart' do
    product = create_product
    visit product_path(product)
    click_on 'Add To Cart'
    expect(page).to have_content 'My Cart'
    expect(page).to have_content 'Great Gatsby'
    expect(page).to have_content 'Total: $10.00'

    # Button to add item to cart is replaced by text after item is added to cart
    visit product_path(product)
    expect(page).to have_content 'Item is already in your cart'
    expect(page).to_not have_content 'Add To Cart'
  end
end
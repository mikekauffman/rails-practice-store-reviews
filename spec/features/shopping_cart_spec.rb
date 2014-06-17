require 'spec_helper'

feature "Shopping Cart" do
  scenario 'user can add items to carts and view details' do
    product = create_product
    visit product_path(product)
    click_on 'Add To Cart'
    expect(page).to have_content 'Great Gatsby is in your cart'
  end
end
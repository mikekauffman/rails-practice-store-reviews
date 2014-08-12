require 'spec_helper'

feature "Stripe Charges" do

  before do
    DatabaseCleaner.clean
  end

  pending "A guest can buy a book", js: true do
    cart = create_products_and_shopping_cart
    visit "/carts/#{cart.cart_id}"
    click_on 'Checkout'
    click_on 'Pay with Card'

    Capybara.within_frame 'stripe_checkout_app' do
      fill_in 'Email', with: "joe@example.com"
      fill_in 'Card number', with: "4242424242424242"
      fill_in 'MM / YY', with: "0317"
      fill_in 'CVC', with: "888"

      click_on 'Pay'
    end

    expect(page).to have_content "Thanks, you paid"
  end
end
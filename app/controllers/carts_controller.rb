class CartsController < ApplicationController
  before_filter :current_cart

  def add
    CartItem.create(:product_id => params[:id], :cart_id => current_cart.id)
    redirect_to cart_path(current_cart)

  end

  def show
    @cart = Cart.find(params[:id])
    @cart_items = CartItem.all.includes(:product)
    total= 0
      @cart_items.each do |item|
      total += item.product.hardcover_price_in_cents
      end
    @total = "$#{Money.new(total, "USD")}"

  end
end


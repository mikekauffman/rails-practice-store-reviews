class CartsController < ApplicationController
  before_filter :current_cart

  def add
    CartItem.create(:product_id => params[:id], :cart_id => current_cart.id)
    redirect_to cart_path(current_cart)

  end

  def show
    @cart = Cart.find(params[:id])
    @cart_items = CartItem.find_by_cart_id(@cart.id)
    @products = Product.find(@cart_items.product_id)
  end
end


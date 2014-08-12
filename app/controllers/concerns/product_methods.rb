module ProductMethods

  def product_show_methods
    @cart_item = CartItem.all
    @reviews = @product.reviews
  end

end
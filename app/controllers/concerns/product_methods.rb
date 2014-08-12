module ProductMethods

  def product_show_variables
    @cart_item = CartItem.all
    @reviews = @product.reviews
  end

end
class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(params.require(:review).permit(:body, :rating))
    user = User.find(session[:id])
    @review.user_id = user.id
    if @review.save
      redirect_to product_path(@product)
    else
      @product = Product.find(params[:product_id])
      @cart_item = CartItem.all
      @reviews = @product.reviews
      render template: 'products/show'
    end
  end
end
class ReviewsController < ApplicationController

  include ProductMethods

  def create
    @product = Product.find(params[:product_id])
    @user = User.find(session[:id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to product_path(@product)
    else
      product_show_methods
      render template: 'products/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating).merge(user: @user, product: @product)
  end

end
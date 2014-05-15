class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(allowed_parameters)
    if @product.save
      redirect_to products_path, alert: "Product successfully added"
    else
      render :new, alert: "Something went wrong"
    end
  end

  private
  def allowed_parameters
    params.require(:product).permit(:name, :hardcover_price, :softcover_price, :image_url, :description, :published_date)
  end
end

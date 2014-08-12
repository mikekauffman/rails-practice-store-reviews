class ProductsController < ApplicationController

  include ProductMethods

  def index
    @products = Product.all
    @cart_item = CartItem.all
  end

  def new
    if is_admin?
      @product = Product.new
    else
      redirect_to root_path, notice: "Access Denied"
    end
  end

  def create
    @product = Product.new(allowed_parameters)
    if @product.save
      redirect_to root_path, notice: "Product successfully added"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    product_show_variables
  end

  private
  def allowed_parameters
    params.require(:product).permit(:name, :hardcover_price,
                                    :softcover_price, :image_url,
                                    :description, :published_date,
                                    :author_id, :publisher_id
                                    )
  end
end

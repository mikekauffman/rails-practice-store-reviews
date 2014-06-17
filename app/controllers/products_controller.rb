class ProductsController < ApplicationController
  def index
    @products = Product.all
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

    @product.hardcover_price_in_cents = convert_price(params[:product][:hardcover_price])
    @product.softcover_price_in_cents = convert_price(params[:product][:softcover_price])

    if @product.save
      redirect_to root_path, notice: "Product successfully added"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @hardcover = Money.new(@product.hardcover_price_in_cents, "USD")
    @softcover = Money.new(@product.softcover_price_in_cents, "USD")
  end

  private
  def allowed_parameters
    params.require(:product).permit(:name, :hardcover_price,
                                    :softcover_price, :image_url,
                                    :description, :published_date,
                                    :author_id, :publisher_id
                                    )
  end

  def convert_price(price)
    price.gsub(".","").to_i
  end
end

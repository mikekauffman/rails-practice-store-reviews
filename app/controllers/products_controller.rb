class ProductsController < ApplicationController
  def index
    new_product = Product.new
    new_product.name = "Making Bricks With 3D-Printers"
    new_product.hardcover_price = 19.99
    new_product.softcover_price = 9.99
    new_product.image_url = 'http://imgur.com/Y03NQEn'
    new_product.description = 'For the poorest programmer'
    new_product.published_date = '1/1/2014'

    new_product.save!

    @products = Product.all
  end
end
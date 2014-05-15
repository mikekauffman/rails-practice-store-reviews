class ProductsController < ApplicationController
  def index
    new_product = Product.new
    new_product.name = "Making Bricks With 3D-Printers"
    new_product.hardcover_price = 19.99
    new_product.softcover_price = 9.99
    new_product.image_url = 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg'
    new_product.description = 'For the poorest programmer'
    new_product.published_date = '1/1/2014'

    new_product.save

    @products = Product.all
  end
end
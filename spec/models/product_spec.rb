require 'spec_helper'

describe Product do
  it 'allows adding of products' do
    new_product = Product.new
    new_product.name = "Making Bricks with 3D Printers"
    new_product.hardcover_price = 19.99
    new_product.softcover_price = 9.99
    new_product.image_url = 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg'
    new_product.description = 'For the poor programmer'
    new_product.published_date = '2014-01-01'

    new_product.save!
  end
end
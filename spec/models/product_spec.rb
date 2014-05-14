require 'spec_helper'

describe Product do
  it 'allows adding of products' do
    new_product = Product.new
    new_product.name = "Making Bricks with 3D Printers"
    new_product.hardcover_price = 19.99
    new_product.softcover_price = 9.99
    new_product.image_url = 'http://imgur.com/Y03NQEn'
    new_product.description = 'For the poor programmer'
    new_product.published_date = ''

    new_product.save!
  end
end
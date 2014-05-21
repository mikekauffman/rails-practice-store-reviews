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

  it 'has access to the author and publisher' do
    author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')

    new_product = Product.new
    new_product.name = "Making Bricks with 3D Printers"
    new_product.hardcover_price = 19.99
    new_product.softcover_price = 9.99
    new_product.image_url = 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg'
    new_product.description = 'For the poor programmer'
    new_product.published_date = '2014-01-01'
    new_product.author_id = author.id
    new_product.publisher_id = publisher.id

    expect(new_product.publisher.name).to eq 'Arthur Books'
    expect(new_product.author.first_name).to eq 'Arthur'
  end
end
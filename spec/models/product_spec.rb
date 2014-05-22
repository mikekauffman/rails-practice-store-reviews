require 'spec_helper'

describe Product do
  before do
    @author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    @publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')
    @new_product = Product.create(
      name: "Making Bricks with 3D Printers",
      hardcover_price: 19.99,
      softcover_price: 9.99,
      image_url: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg',
      description: 'For the poor programmer',
      published_date: '2014-01-01'
    )
  end

  it 'allows adding of products' do
    @new_product.author_id = @author.id
    @new_product.publisher_id = @publisher.id

    @new_product.save!
  end

  it 'has access to the author and publisher' do
    @new_product.author_id = @author.id
    @new_product.publisher_id = @publisher.id

    expect(@new_product.publisher.name).to eq 'Arthur Books'
    expect(@new_product.author.first_name).to eq 'Arthur'
  end

  it 'requires an author and publisher' do
    @new_product.author_id = nil
    @new_product.publisher_id = nil

    expect(@new_product.valid?).to eq false
  end
end
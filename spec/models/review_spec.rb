require 'spec_helper'

describe Review do

  before do
    DatabaseCleaner.clean
    @user = User.create!(
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: true
    )
    author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')
    @product = Product.create!(
      name: 'Test Book',
      hardcover_price_in_cents: 1000,
      softcover_price_in_cents: 800,
      description: 'This is a description',
      image_url: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg',
      published_date: '1/1/2010',
      author_id: author.id,
      publisher_id: publisher.id
    )
  end

  it 'allows a review to be created' do
    review = Review.new(body: "Great book", rating: 5, product: @product, user: @user)
    expect(review).to be_valid
  end

  it 'review must have a product' do
    review = Review.new(body: "Great book", rating: 5, product_id: nil, user: @user)
    expect(review).to_not be_valid
  end

  it 'review must have a user' do
    review = Review.new(body: "Great book", rating: 5, product: @product, user_id: nil)
    expect(review).to_not be_valid
  end

  it 'review must have a body' do
    review = Review.new(body: "", rating: 5, product: @product, user: @user)
    expect(review).to_not be_valid
  end

  it 'review must have a rating' do
    review = Review.new(body: "Great book", rating: nil, product: @product, user: @user)
    expect(review).to_not be_valid
  end


end
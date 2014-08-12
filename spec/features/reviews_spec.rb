require 'spec_helper'

feature 'writing reviews on products' do
  before do
    DatabaseCleaner.clean
    user = User.create!(
      email: 'admin@example.com',
      password: 'password1',
      password_confirmation: 'password1',
      admin: true
    )
    author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')
    Product.create!(
      name: 'Test Book',
      hardcover_price_in_cents: 1000,
      softcover_price_in_cents: 800,
      description: 'This is a description',
      image_url: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg',
      published_date: '1/1/2010',
      author_id: author.id,
      publisher_id: publisher.id
    )

    log_in(user)
  end

  def log_in(user)
    visit '/'
    click_link 'Login'
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'Login'
  end

  scenario 'Users can write reviews for products' do
    visit '/'

    click_on 'Test Book'

    expect(page).to have_content 'Test Book'
    expect(page).to have_content 'Reviews'
    expect(page).to have_content 'New Review'

    fill_in 'review_body', with: 'This is an awesome book!'
    select 5, from: 'review_rating'
    click_on 'Submit Review'

    expect(page).to have_content 'This is an awesome book!'
    expect(page).to have_content '(5 stars)'
    expect(page).to have_content 'admin@example.com'
  end

  scenario 'Users must enter a body and a rating for a review' do
    visit '/'

    click_on 'Test Book'

    expect(page).to have_content 'Test Book'
    expect(page).to have_content 'Reviews'
    expect(page).to have_content 'New Review'

    fill_in 'review_body', with: ''
    select nil, from: 'review_rating'
    click_on 'Submit Review'

    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Rating can't be blank"
  end

end

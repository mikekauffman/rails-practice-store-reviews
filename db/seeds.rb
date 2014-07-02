User.create!(
  email: 'admin@admin.com',
  password: 'password1',
  password_confirmation: 'password1',
  admin: true
)
User.create!(
  email: 'user@user.com',
  password: 'password1',
  password_confirmation: 'password1',
  admin: false
)

publisher_attributes = {
  :city => 'Boulder',
  :name => 'Random House'
}

publisher = Publisher.create(publisher_attributes)

author_attributes = {
  :first_name => 'Leo',
  :last_name => 'Tolstoy',
  :bio => 'Russian Dude'
}

author = Author.create(author_attributes)

product_attributes = {
  :name => 'Great Gatsby',
  :hardcover_price => '10.00',
  :softcover_price => '7.00',
  :image_url => 'http://www.jgrisham.com/images/book-theclient-lg.jpg',
  :description => 'this is a book',
  :published_date => '12-12-12',
  :author_id => author.id,
  :publisher_id => publisher.id
}



Product.create(product_attributes)
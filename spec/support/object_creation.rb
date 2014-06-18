def create_product(updated_attributes = {})
  publisher = create_publisher
  author = create_author
  default_attributes = {
    :name => 'Great Gatsby',
    :hardcover_price => '10',
    :softcover_price => '7',
    :image_url => 'http://www.jgrisham.com/images/book-theclient-lg.jpg',
    :description => 'this is a book',
    :published_date => '12-12-12',
    :author_id => author.id,
    :publisher_id => publisher.id
  }

  attributes = default_attributes.merge(updated_attributes)

  Product.create(attributes)
end

def create_publisher(updated_attributes = {})
  default_attributes = {
    :city => 'Boulder',
    :name => 'Random House'
  }

  attributes = default_attributes.merge(updated_attributes)

  Publisher.create(attributes)
end

def create_author(updated_attributes = {})
  default_attributes = {
    :first_name => 'Leo',
    :last_name => 'Tolstoy',
    :bio => 'Russian Dude'
  }

  attributes = default_attributes.merge(updated_attributes)

  Author.create(attributes)
end
class Author < ActiveRecord::Base
  has_many :products
end
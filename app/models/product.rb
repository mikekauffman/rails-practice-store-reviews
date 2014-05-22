class Product < ActiveRecord::Base
  belongs_to :author
  belongs_to :publisher

  validates :author_id, :publisher_id, presence: true
end
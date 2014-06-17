class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader
  belongs_to :author
  belongs_to :publisher

  validates :author_id, :publisher_id, presence: true, allow_blank: false

  attr_accessor :hardcover_price, :softcover_price

end

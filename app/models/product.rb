class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader
  belongs_to :author
  belongs_to :publisher
  has_many :cart_items
  has_many :carts, :through => :cart_items

  validates :author_id, :publisher_id, presence: true
end
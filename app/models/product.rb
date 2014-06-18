class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader
  belongs_to :author
  belongs_to :publisher

  validates :author_id, :publisher_id, presence: true, allow_blank: false

  def hardcover_price=(price)
    self.hardcover_price_in_cents = price_to_cents(price)
  end

  def hardcover_price
    format_as_money(self.hardcover_price_in_cents)
  end

  def softcover_price=(price)
    self.softcover_price_in_cents = price_to_cents(price)
  end

  def softcover_price
    format_as_money(self.softcover_price_in_cents)
  end

  private
  def price_to_cents(price)
    price.delete(' ').delete('$').strip.gsub(".", "").to_i
  end

  def format_as_money(price)
    "$#{Money.new(price, "USD")}"
  end
end

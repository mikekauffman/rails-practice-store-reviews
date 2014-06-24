class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader
  belongs_to :author
  belongs_to :publisher
  has_many :cart_items
  has_many :carts, :through => :cart_items

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
  def strip_money(digit_only_price)
    digit_only_price.gsub(".", "").to_i
  end
  
  def price_to_cents(price)
    digit_only_price = price.delete('$')
    
    if digit_only_price.match(/\.(\d{2})/)
      strip_money(digit_only_price)
    elsif digit_only_price.match(/\.(\d{1})/)
      digit_only_price = "#{digit_only_price}0"
      strip_money(digit_only_price)
    elsif
      !digit_only_price.include?(".")
      strip_money(digit_only_price) * 100
    elsif
      digit_only_price.include?(".")
      digit_only_price.strip.to_i * 100
    else
      strip_money(digit_only_price)
    end
  end

  def format_as_money(price)
    "$#{Money.new(price, "USD")}"
  end

end

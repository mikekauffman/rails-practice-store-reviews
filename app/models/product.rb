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
  def price_to_cents(price)
    digit_only_price = price.delete('$')
    
    if digit_only_price.match(/\.(\d{2})/)
      digit_only_price.delete(' ').strip.gsub(".", "").to_i
    elsif digit_only_price.match(/\.(\d{1})/)
      digit_only_price = "#{digit_only_price}0"
      digit_only_price.delete(' ').strip.gsub(".", "").to_i
    elsif
      !digit_only_price.include?(".") 
      digit_only_price.delete(' ').strip.to_i * 100
    elsif
      digit_only_price.include?(".")
      digit_only_price.delete(' ').strip.to_i * 100
    else
      digit_only_price.delete(' ').strip.gsub(".", "").to_i
    end
  end

  def format_as_money(price)
    "$#{Money.new(price, "USD")}"
  end

end

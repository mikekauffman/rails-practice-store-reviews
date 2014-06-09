class Product < ActiveRecord::Base
  mount_uploader :image_url, ImageUploader
  belongs_to :author
  belongs_to :publisher

  validates :author_id, :publisher_id, presence: true, allow_blank: false


  def self.create_and_convert_money(params)
    create do |product|
      product.name = params[:name]
      product.hardcover_price = (params[:hardcover_price].to_f * 100).round
      product.softcover_price = (params[:softcover_price].to_f * 100).round
      product.description = params[:description]
      product.published_date = params[:published_date]
      product.author_id = params[:author_id]
      product.publisher_id = params[:publisher_id]
      product.image_url = params[:image_url]
    end
  end
end
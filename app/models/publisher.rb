class Publisher < ActiveRecord::Base
  validates :name, :city, presence: true
  has_many :products
end

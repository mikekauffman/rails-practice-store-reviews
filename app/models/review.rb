class Review < ActiveRecord::Base
belongs_to :user
belongs_to :product

  validates :body, presence: true
  validates :rating, presence: true
  validates :user, presence: true
  validates :product, presence: true
end
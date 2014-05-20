class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i }
end

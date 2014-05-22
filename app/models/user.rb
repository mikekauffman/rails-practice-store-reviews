class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i }

  validates :password,
            format: { with: /\A^(?=.*\d)(?=.*[a-zA-Z]).{8,12}$\z/ }


end

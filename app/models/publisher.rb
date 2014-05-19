class Publisher < ActiveRecord::Base

  validates :name, :city, presence: true

end

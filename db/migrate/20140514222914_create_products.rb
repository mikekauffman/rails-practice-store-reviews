class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :hardcover_price
      t.float :softcover_price
      t.string :image_url
      t.string :description
      t.date  :published_date

      t.timestamps
    end
  end
end

class ChangeProductsHardcoverPriceAndSoftcoverPrice < ActiveRecord::Migration
  class Product < ActiveRecord::Base
  end

  def change
    Product.reset_column_information
    reversible do |dir|
      dir.up { Product.all.each { |p| p.update(hardcover_price: p.hardcover_price*100, softcover_price: p.softcover_price*100) } }
    end

    change_table :products do |t|
      t.change :hardcover_price, :integer
      t.change :softcover_price, :integer
    end
  end
end

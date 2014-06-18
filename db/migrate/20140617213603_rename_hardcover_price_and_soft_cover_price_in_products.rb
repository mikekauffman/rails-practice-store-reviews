class RenameHardcoverPriceAndSoftCoverPriceInProducts < ActiveRecord::Migration
  def up
    rename_column :products, :hardcover_price, :hardcover_price_in_cents
    rename_column :products, :softcover_price, :softcover_price_in_cents
  end

  def down
    rename_column :products, :hardcover_price_in_cents, :hardcover_price
    rename_column :products, :softcover_price_in_cents, :softcover_price
  end
end

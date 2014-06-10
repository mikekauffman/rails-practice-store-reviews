class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.column :product_id, :integer
      t.column :cart_id, :integer
      t.timestamps
    end
  end
end

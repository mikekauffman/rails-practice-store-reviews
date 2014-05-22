class AssociateProductsWithPublishers < ActiveRecord::Migration
  def change
    add_column :products, :publisher_id, :integer
    add_index :products, :publisher_id
  end
end

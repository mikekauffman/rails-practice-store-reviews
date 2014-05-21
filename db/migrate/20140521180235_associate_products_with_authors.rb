class AssociateProductsWithAuthors < ActiveRecord::Migration
  def change
    add_column :products, :author_id, :integer
    add_index :products, :author_id
  end
end

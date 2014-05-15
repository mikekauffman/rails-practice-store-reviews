class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :city
      t.string :name
      t.timestamps
    end
  end
end

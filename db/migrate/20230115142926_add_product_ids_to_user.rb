class AddProductIdsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :product_ids, :integer, array: true, default: []
  end
end

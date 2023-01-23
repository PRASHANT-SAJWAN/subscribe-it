class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :plan_id
      t.string :stripe_product_id

      t.timestamps
    end
  end
end

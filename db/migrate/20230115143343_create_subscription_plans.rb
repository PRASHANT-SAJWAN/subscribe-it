class CreateSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_plans do |t|
      t.timestamp :start_date
      t.timestamp :due_date
      t.string :status
      t.string :period

      t.timestamps
    end
  end
end

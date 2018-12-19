class CreateSubscriptionPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_plans do |t|
      t.string :name, null: false
      t.string :stripe_id
      t.integer :interval, default:0
      t.integer :interval_count, default:0
      t.integer :trial_period_days

      t.timestamps
    end
    add_index :subscription_plans, :stripe_id, unique: true
  end
end

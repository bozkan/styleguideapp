class MonetizeSubscriptionPlans < ActiveRecord::Migration[5.2]
  def change
    add_monetize :subscription_plans, :amount
  end
end

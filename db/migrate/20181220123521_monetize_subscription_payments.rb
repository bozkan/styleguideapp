class MonetizeSubscriptionPayments < ActiveRecord::Migration[5.2]
  def change
    add_monetize :subscription_payments, :amount
  end
end

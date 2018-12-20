class AddAccountToSubscriptionPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscription_payments, :account, foreign_key: true
  end
end

class AddStripeCustomerIdToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :stripe_customer_id, :string
    add_index :accounts, :stripe_customer_id, unique: true, where: 'stripe_customer_id IS NOT NULL'
  end
end

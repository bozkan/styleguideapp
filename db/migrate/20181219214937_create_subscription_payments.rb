class CreateSubscriptionPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_payments do |t|
      t.references :subscription, foreign_key: true
      t.string :transaction_id
      t.boolean :paid, default: true

      t.timestamps
    end
    add_index :subscription_payments, :transaction_id, unique: true
  end
end

class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :subscription_plan, foreign_key: true
      t.string :stripe_id
      t.integer :status, default: 0
      t.datetime :expiration
      t.references :account, index: {:unique=>true}, foreign_key: true

      t.timestamps
    end
    add_index :subscriptions, :stripe_id, unique: true
  end
end

class CreateAccountsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts_users do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :accounts_users, [:account_id, :user_id], unique: true
  end
end

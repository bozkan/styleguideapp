class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.string :email
      t.references :account, foreign_key: true
      t.references :brand, foreign_key: true
      t.string :token

      t.timestamps
    end
    add_index :invites, :email, unique: true
  end
end

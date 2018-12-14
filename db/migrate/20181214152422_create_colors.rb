class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.references :brand, foreign_key: true
      t.string :hex, null: false

      t.timestamps
    end
  end
end

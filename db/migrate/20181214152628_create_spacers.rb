class CreateSpacers < ActiveRecord::Migration[5.2]
  def change
    create_table :spacers do |t|
      t.references :brand, foreign_key: true
      t.integer :size, default: 4, null: false

      t.timestamps
    end
  end
end

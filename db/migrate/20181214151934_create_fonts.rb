class CreateFonts < ActiveRecord::Migration[5.2]
  def change
    create_table :fonts do |t|
      t.references :brand, foreign_key: true
      t.string :name
      t.decimal :size
      t.decimal :line_height
      t.integer :weight

      t.timestamps
    end
  end
end

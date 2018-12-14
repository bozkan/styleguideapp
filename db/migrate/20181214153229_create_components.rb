class CreateComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :components do |t|
      t.references :brand, foreign_key: true
      t.string :name
      t.text :description
      t.text :markup
      t.text :style

      t.timestamps
    end
  end
end

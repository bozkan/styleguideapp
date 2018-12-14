class CreateColorCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :color_categories do |t|
      t.references :brand, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end

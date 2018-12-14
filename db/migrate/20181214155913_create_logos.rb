class CreateLogos < ActiveRecord::Migration[5.2]
  def change
    create_table :logos do |t|
      t.references :brand, foreign_key: true
      t.text :file_data
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

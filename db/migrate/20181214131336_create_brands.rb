class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.references :account, foreign_key: true
      t.string :name
      t.string :subdomain, unique:true

      t.timestamps
    end
    add_index :brands, :subdomain, unique: true
  end
end

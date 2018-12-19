class AddWebsiteToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :website, :string
  end
end

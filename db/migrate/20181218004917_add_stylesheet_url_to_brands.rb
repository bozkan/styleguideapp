class AddStylesheetUrlToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :stylesheet_url, :string
  end
end

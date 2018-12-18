class ChangeFontAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column :fonts, :size, :integer
    remove_column :fonts, :line_height, :integer
    add_column :fonts, :size, :string
    add_column :fonts, :line_height, :string
  end
end

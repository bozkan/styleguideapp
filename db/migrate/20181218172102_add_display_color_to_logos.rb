class AddDisplayColorToLogos < ActiveRecord::Migration[5.2]
  def change
    add_column :logos, :display_color, :string
  end
end

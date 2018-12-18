class AddColorCategoryToColors < ActiveRecord::Migration[5.2]
  def change
    add_reference :colors, :color_category, foreign_key: true
  end
end

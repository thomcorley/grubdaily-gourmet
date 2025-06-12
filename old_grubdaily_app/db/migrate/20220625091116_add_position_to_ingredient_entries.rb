class AddPositionToIngredientEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredient_entries, :position, :integer
  end
end

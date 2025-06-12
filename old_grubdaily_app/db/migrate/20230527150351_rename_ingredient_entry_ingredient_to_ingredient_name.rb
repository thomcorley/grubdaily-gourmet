class RenameIngredientEntryIngredientToIngredientName < ActiveRecord::Migration[7.0]
  def change
    rename_column :ingredient_entries, :ingredient, :ingredient_name
  end
end

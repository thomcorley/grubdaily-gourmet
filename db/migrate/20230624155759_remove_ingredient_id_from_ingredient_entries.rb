class RemoveIngredientIdFromIngredientEntries < ActiveRecord::Migration[7.0]
  def change
    remove_column :ingredient_entries, :ingredient_id
  end
end

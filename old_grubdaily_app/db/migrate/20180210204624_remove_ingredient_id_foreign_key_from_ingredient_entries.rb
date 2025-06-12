class RemoveIngredientIdForeignKeyFromIngredientEntries < ActiveRecord::Migration[5.1]
  def change
    remove_index :ingredient_entries, :ingredient_id
  end
end

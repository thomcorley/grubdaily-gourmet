class AddIngredientSetIdIndexToIngredientEntries < ActiveRecord::Migration[5.1]
  def change
  	add_index :ingredient_entries, :ingredient_set_id
  end
end

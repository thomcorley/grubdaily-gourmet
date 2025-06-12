class AddIngredientSetIdToIngredientEntries < ActiveRecord::Migration[5.1]
  def change
  	add_column :ingredient_entries, :ingredient_set_id, :integer
  end
end

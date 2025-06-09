class AddIngredientColumnToIngredientEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredient_entries, :ingredient, :string
  end
end

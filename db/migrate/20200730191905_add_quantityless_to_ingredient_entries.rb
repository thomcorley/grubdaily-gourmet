class AddQuantitylessToIngredientEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredient_entries, :quantityless, :boolean
  end
end

class AddOriginalStringToIngredientEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredient_entries, :original_string, :string
  end
end

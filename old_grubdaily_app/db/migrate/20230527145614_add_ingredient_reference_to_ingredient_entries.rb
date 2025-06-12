class AddIngredientReferenceToIngredientEntries < ActiveRecord::Migration[7.0]
  def change
    add_reference :ingredient_entries, :ingredient, foreign_key: true
  end
end

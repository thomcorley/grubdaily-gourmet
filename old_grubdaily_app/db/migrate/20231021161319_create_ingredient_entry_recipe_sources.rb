class CreateIngredientEntryRecipeSources < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_entry_recipe_sources do |t|
      t.references :ingredient_entry, null: false, foreign_key: true, index: { name: :index_ingredient_entry_recipe_entry_source }
      t.references :recipe, null: false, foreign_key: true, index: { name: :index_recipe_recipe_entry_source }

      t.timestamps
    end
  end
end

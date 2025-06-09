class CreateIngredientEntryIngredientSources < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredient_entry_ingredient_sources do |t|
      t.references :ingredient_entry, null: false, foreign_key: true, index: { name: :index_ingredient_entry_source }
      t.references :ingredient, null: false, foreign_key: true, index: { name: :index_ingredient_source }

      t.timestamps
    end
  end
end

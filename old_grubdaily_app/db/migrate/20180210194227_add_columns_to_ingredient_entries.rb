class AddColumnsToIngredientEntries < ActiveRecord::Migration[5.1]
  def change
    change_table :ingredient_entries do |t|
      t.integer :quantity
      t.string :unit
      t.string :size
      t.string :modifier
      t.references :ingredient
    end
  end
end

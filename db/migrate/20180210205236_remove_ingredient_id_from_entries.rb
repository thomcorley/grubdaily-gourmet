class RemoveIngredientIdFromEntries < ActiveRecord::Migration[5.1]
  def change
    change_table :ingredient_entries do |t|
      t.remove :ingredient_id
    end
  end
end

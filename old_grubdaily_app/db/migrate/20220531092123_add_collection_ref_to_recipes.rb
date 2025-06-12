class AddCollectionRefToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :collection, null: true, foreign_key: true
  end
end

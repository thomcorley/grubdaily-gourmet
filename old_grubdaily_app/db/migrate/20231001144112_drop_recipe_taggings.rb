class DropRecipeTaggings < ActiveRecord::Migration[7.0]
  def change
    drop_table :recipe_taggings
  end
end

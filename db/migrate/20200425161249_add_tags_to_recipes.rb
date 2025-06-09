class AddTagsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :tags, :string
  end
end

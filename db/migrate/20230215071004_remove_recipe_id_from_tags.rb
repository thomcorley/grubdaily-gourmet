class RemoveRecipeIdFromTags < ActiveRecord::Migration[7.0]
  def change
    remove_column :tags, :recipe_id, :integer
  end
end

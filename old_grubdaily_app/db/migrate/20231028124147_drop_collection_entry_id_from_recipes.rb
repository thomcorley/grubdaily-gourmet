class DropCollectionEntryIdFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :collection_id
  end
end

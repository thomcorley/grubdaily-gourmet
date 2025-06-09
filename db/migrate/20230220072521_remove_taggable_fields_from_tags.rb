class RemoveTaggableFieldsFromTags < ActiveRecord::Migration[7.0]
  def change
    remove_column :tags, :taggable_type, :string
    remove_column :tags, :taggable_id, :integer
    add_index :tags, :name
  end
end

class CreateRecipeTaggings < ActiveRecord::Migration[7.0]
  def change
    create_join_table :recipes, :tags, table_name: :recipe_taggings do |t|
      t.primary_key :id
      t.index :recipe_id
      t.index :tag_id
      t.timestamps
    end
  end
end

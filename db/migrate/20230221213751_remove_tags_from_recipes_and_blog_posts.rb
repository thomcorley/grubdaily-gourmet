class RemoveTagsFromRecipesAndBlogPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :tags, :string
    remove_column :blog_posts, :tags, :string
  end
end

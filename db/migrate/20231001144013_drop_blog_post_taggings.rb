class DropBlogPostTaggings < ActiveRecord::Migration[7.0]
  def change
    drop_table :blog_post_taggings
  end
end

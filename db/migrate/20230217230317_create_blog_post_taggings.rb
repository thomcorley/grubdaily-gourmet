class CreateBlogPostTaggings < ActiveRecord::Migration[7.0]
  def change
    create_join_table :blog_posts, :tags, table_name: :blog_post_taggings do |t|
      t.primary_key :id
      t.index :blog_post_id
      t.index :tag_id
      t.timestamps
    end
  end
end

class CreateBlogPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.string :images
      t.string :tags
      t.boolean :published
      t.datetime :published_at
    end
  end
end

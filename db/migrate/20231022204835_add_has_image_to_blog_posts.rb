class AddHasImageToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :has_image, :boolean
  end
end

class ChangeImagesToText < ActiveRecord::Migration[6.0]
  def change
    change_column :blog_posts, :images, :text
  end
end

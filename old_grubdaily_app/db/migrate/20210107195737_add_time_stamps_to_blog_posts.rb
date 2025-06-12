class AddTimeStampsToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :blog_posts
  end
end

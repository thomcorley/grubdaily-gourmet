class AddPublishedAtToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :published_at, :datetime
  end
end

class RemoveForeignKeyFromTags < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :tags, :recipes
  end
end

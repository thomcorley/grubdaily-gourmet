class AddForiegnKeyToTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :tags, :recipe, foreign_key: true
  end
end

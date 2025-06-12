class AddTaggableTypeToTags < ActiveRecord::Migration[5.1]
  def change
    change_table :tags do |t|
      t.references :taggable, :polymorphic => true
    end
  end
end

class AddHasImageToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :has_image, :boolean
  end
end

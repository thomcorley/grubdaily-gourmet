class ChangeColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :tags, :name, :string
  end
end

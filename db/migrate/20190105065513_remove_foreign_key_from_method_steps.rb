class RemoveForeignKeyFromMethodSteps < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :method_steps, :recipes
  end
end

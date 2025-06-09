class AddForeignKeyToMethodSteps < ActiveRecord::Migration[5.1]
  def change
    add_reference :method_steps, :recipe, foreign_key: true
  end
end

class ChangeQuantityToBeFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :ingredient_entries, :quantity, :float
  end
end

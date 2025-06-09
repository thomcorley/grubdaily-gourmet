class IngredientEntryIngredientSource < ApplicationRecord
  belongs_to :ingredient_entry
  belongs_to :ingredient
end

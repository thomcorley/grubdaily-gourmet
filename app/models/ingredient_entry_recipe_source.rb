class IngredientEntryRecipeSource < ApplicationRecord
  belongs_to :ingredient_entry
  belongs_to :recipe
end

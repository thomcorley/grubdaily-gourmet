class IngredientSetSerializer < ActiveModel::Serializer
  attributes :title, :position, :ingredient_entries

  has_many :ingredient_entries, serializer: IngredientEntrySerializer
  belongs_to :recipe, serializer: RecipeSerializer
end

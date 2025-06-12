class MethodStepSerializer < ActiveModel::Serializer
  attributes :id, :position, :description, :created_at, :updated_at, :recipe_id

  belongs_to :recipe, serializer: RecipeSerializer
end

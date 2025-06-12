class IngredientEntrySerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :quantity, :unit, :size, :modifier, :ingredient_set_id,
             :original_string, :human_readable_entry, :ingredient_name, :quantityless, :position

  belongs_to :ingredient_set, serializer: IngredientSetSerializer

  def human_readable_entry
    object.human_readable_entry
  end
end

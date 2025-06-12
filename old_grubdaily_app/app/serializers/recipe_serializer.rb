class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :summary, :total_time, :introduction, :serves, :makes, :makes_unit, :serves_or_makes_text,
             :recipe_type, :created_at, :updated_at, :category, :image_url, :published,
             :published_at, :marked_for_promotion_at, :related_recipe_ids, :related_recipes_heading,
             :has_image, :slug, :images

  has_many :ingredient_sets, serializer: IngredientSetSerializer
  has_many :method_steps, serializer: MethodStepSerializer

  def slug
    object.permalink[1..-1]
  end

  def images
    object.images
  end

  def portion
    object.serves_or_makes_text
  end
end

# frozen_string_literal: true
class RecipeRepository
  class << self
    def sample(count)
      Recipe.published_with_image.order(Arel.sql("RANDOM()")).limit(count)
    end

    def with_term_in_title(term)
      recipes.where("LOWER(recipes.title) LIKE ?", "%#{term}%")
    end

    def with_term_in_ingredients(term)
      recipes.joins(ingredient_sets: :ingredient_entries)
             .where("LOWER(ingredient_entries.ingredient_name) LIKE ?", "%#{term}%")
    end

    def with_term_in_introducion(term)
      recipes.where("LOWER(recipes.introduction) LIKE ?", "%#{term}%")
    end

    def recipes_containing_ingredients(ingredients)
      Queries::RecipeWithIngredients.new(ingredients: ingredients).result
    end

    def recipes
      @recipes ||= Recipe.published_with_image.joins(ingredient_sets: :ingredient_entries)
    end
  end

  private_class_method :recipes
end

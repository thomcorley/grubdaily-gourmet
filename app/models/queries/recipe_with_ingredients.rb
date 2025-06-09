# frozen_string_literal: true
module Queries
  class RecipeWithIngredients
    def initialize(ingredients:)
      @ingredients = ingredients
    end

    def result
      recipe_groups = aggregated_ingredients_by_recipe_id.select do |group|
        string = group.last.join(" ")
        ingredients.all? { |ingredient| string =~ /#{ingredient}/ }
      end

      Recipe.find(recipe_groups.map(&:first))
    end

    private

    # Returns a list of recipe IDs and their corresponding ingredients:
    #
    # [
    #  [21, ["bacon lardons", "silver skin onions"]],
    #  [22, ["garlic cloves", "spring onions"]]
    # ]
    def aggregated_ingredients_by_recipe_id
      IngredientEntry.joins(:recipe)
                     .where("ingredient_entries.ingredient_name ~ ?", "#{ingredients.join("|")}")
                     .group(:recipe_id)
                     .pluck(:recipe_id, "ARRAY_AGG(ingredient_entries.ingredient_name)")
    end

    attr_reader :ingredients
  end
end

# frozen_string_literal: true
class RecipeSearch
  def initialize(query:, repository: RecipeRepository)
    @repository = repository
    @query = query
  end

  def result
    recipes_containing_term(@query).uniq

    # TODO: update this to handle commas in the query to indicate multiple ingredients,
    # as the current approach of assuming multiple ingredients separated by spaces
    # doesn't allow for ingredient names with spaces in eg: 'peanut caramel'
    #
    # if ingredients.none?
    #   repository.sample(10)
    # elsif ingredients.count == 1
    #   recipes_containing_term(ingredients.first).uniq.first(10)
    # else
    #   repository.recipes_containing_ingredients(ingredients).first(10)
    # end
  end

  private

  attr_reader :ingredients, :repository

  def set_ingredients(query)
    @ingredients = query.downcase.delete(" ","").split(" ")
  end

  def recipes_containing_term(term)
    repository.with_term_in_title(term) +
      repository.with_term_in_ingredients(term) +
      repository.with_term_in_introducion(term)
  end
end

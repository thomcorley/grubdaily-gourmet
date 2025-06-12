class FullRecipeFormatter
  def initialize(full_recipe)
    @full_recipe = full_recipe
  end

  def save_recipe
    @recipe = Recipe.new(recipe_params(parsed_recipe))
    @recipe.save
  end

  # def save_ingredient_set
  #   @ingredient_set = IngredientSet
  # end


  private

  def parsed_recipe
    @parsed_recipe = YAML.load(@full_recipe.content).deep_symbolize_keys
  end

  def recipe_params(parsed_full_recipe)
    r = parsed_full_recipe
    params = {
      title: r[:title],
      summary: r[:summary],
      total_time: r[:total_time],
      introduction: r[:introduction],
      serves: r[:serves],
      makes: r[:makes],
      recipe_type: r[:type]
    }
  end

  def ingredient_set_params(parsed_recipe)
    params = {
      title: parsed_full_recipe[:title],
      recipe_id: @recipe.id
    }
  end
end

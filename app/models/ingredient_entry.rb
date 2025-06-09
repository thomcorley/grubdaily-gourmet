class IngredientEntry < ApplicationRecord
  belongs_to :ingredient_set

  has_one :ingredient_entry_ingredient_source
  has_one :ingredient, through: :ingredient_entry_ingredient_source

  has_one :ingredient_entry_recipe_source
  has_one :recipe, through: :ingredient_entry_recipe_source

  alias_attribute :name, :ingredient

  before_save :assign_ingredient
  before_save :assign_recipe

  def human_readable_entry
    HumanReadableEntryGenerator.new(self).generate
  end

  private

  def assign_ingredient
    self.ingredient = Ingredient.find_by_synonym(self.ingredient_name)
  end

  def assign_recipe
    self.recipe = Recipe.find_by_synonym(self.ingredient_name)
  end
end

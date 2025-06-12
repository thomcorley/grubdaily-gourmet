# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Importing a Recipe from a YAML file" do
  before(:all) do
    yaml_content = File.read("spec/test_data/benchmark_test_recipe.yaml")
    importer = RecipeImporter.new(yaml_content)
    @recipe_id = importer.save_recipe
    importer.save_ingredients(@recipe_id)
    importer.save_method_steps(@recipe_id)
  end

  let(:recipe) { Recipe.find(@recipe_id) }
  let(:recipe_attributes) { recipe.attributes.deep_symbolize_keys  }

  context "recipe attributes" do
    expected_recipe_attributes =  {
      title: "Best Ever Random Pancakes",
      total_time: "PT2D4H23M",
      serves: nil,
      makes: 45,
      makes_unit:  "pancakes",
      recipe_type: "brunch",
      category: "pancakes",
      summary: "This is my _favourite_ pancakes recipe in the world",
    }

    expected_recipe_attributes.each do |key, value|
      it "has the correct #{key}" do
        expect(recipe_attributes[key]).to eq(value)
      end
    end

    it "has the correct tags" do
      expect(recipe.tags.first).to be_a(Tag)
      expect(recipe.tags.map(&:name)). to eq(["pancakes", "British", "tasty brunch", "delicious"])
    end
  end

  context "ingredient sets" do
    it "has the correct title for each set" do
      expected_ingredient_set_names = [nil, "to finish"]
      actual_ingredient_set_names = recipe.ingredient_sets.map(&:title)

      expect(expected_ingredient_set_names).to eq(actual_ingredient_set_names)
    end
  end

  context "ingredient entries" do
    shared_examples "attributes are correct" do |expected_attributes|
      let(:ingredient_entry) { IngredientEntry.find_by(original_string: original_string) }
      let(:ingredient_entry_attributes) { ingredient_entry.attributes.deep_symbolize_keys }

      expected_attributes.each do |key, value|
        it "has the correct #{key}" do
          expect(ingredient_entry_attributes[key]).to eq(value)
        end
      end
    end

    context "415g warm water" do
      expected_attributes = {
        quantity: 415,
        unit: "g",
        size: nil,
        modifier: nil,
        ingredient_name: "warm water",
      }

      let(:original_string) { "415g warm water" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "725 pinches plain flour" do
      expected_attributes = {
        quantity: 725,
        unit: "pinch",
        size: nil,
        modifier: nil,
        ingredient_name: "plain flour",
      }

      let(:original_string) { "725 pinches plain flour" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "10 carrots" do
      expected_attributes = {
        quantity: 10,
        unit: nil,
        size: nil,
        modifier: nil,
        ingredient_name: "carrots",
      }

      let(:original_string) { "10 carrots" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "34 large onions, finely chopped" do
      expected_attributes = {
        quantity: 34,
        unit: nil,
        size: "large",
        modifier: "finely chopped",
        ingredient_name: "onions",
      }

      let(:original_string) { "34 large onions, finely chopped" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "1/2 leek" do
      expected_attributes = {
        quantity: 0.5,
        unit: nil,
        size: nil,
        modifier: nil,
        ingredient_name: "leek",
      }

      let(:original_string) { "1/2 leek" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "1/2 handful of pinenuts" do
      expected_attributes = {
        quantity: 0.5,
        unit: "handful",
        size: nil,
        modifier: nil,
        ingredient_name: "pinenuts",
      }

      let(:original_string) { "1/2 handful of pinenuts" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    xcontext "2 x 400g tins tomatoes" do
      expected_attributes = {
        quantity: 2,
        unit: nil,
        size: nil,
        modifier: nil,
        ingredient_name: "400g tin tomatoes",
      }

      let(:original_string) { "2 x 400g tins tomatoes" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "100g cavolo nero (black kale)" do
      expected_attributes = {
        quantity: 100,
        unit: "g",
        size: nil,
        modifier: "black kale",
        ingredient_name: "cavolo nero"
      }

      let(:original_string) { "100g cavolo nero (black kale)" }

      it_behaves_like("attributes are correct", expected_attributes)
    end

    context "10 carrots, cut into 5mm dice" do
      expected_attributes = {
        quantity: 10,
        unit: nil,
        size: nil,
        modifier: "cut into 5mm dice",
        ingredient_name: "carrots"
      }

      let(:original_string) { "10 carrots, cut into 5mm dice" }

      it_behaves_like("attributes are correct", expected_attributes)
    end
  end
end

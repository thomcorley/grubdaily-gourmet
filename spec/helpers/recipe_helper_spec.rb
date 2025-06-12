require "rails_helper"

RSpec.describe RecipeHelper do
  describe "#serves_or_makes_text" do
    let(:subject) { helper.serves_or_makes_text }
    let(:recipe) { FactoryBot.create(:recipe) }
    before { assign(:recipe, recipe) }

    context "when serves is present" do
      before { recipe.update!(serves: 5, makes: nil) }
      it { is_expected.to eq "Serves 5" }
    end

    context "when makes and makes unit is present" do
      before { recipe.update!(serves: nil, makes: "2", makes_unit: "loaves") }
      it { is_expected.to eq "Makes 2 loaves" }
    end
  end

  describe "#recipe_json_schema" do
    let(:recipe) { FactoryBot.create(:recipe) }
    let(:parsed_json) { JSON.parse(helper.recipe_json_schema) }
    before { assign(:recipe, recipe) }

    it "generates valid json" do
      expect(parsed_json).to be_truthy
    end

    it "has the correct keys" do
      expected_keys = ["@context", "@type", "name", "author", "image"]
      actual_keys = parsed_json.keys.first(5)

      expect(expected_keys).to eq actual_keys
    end

    context "ingredients and method steps" do
      before(:each) do
        ingredient_set = FactoryBot.create(:ingredient_set, recipe: recipe)
        FactoryBot.create_list(:ingredient_entry, 2, ingredient_set: ingredient_set)
        FactoryBot.create_list(:method_step, 2, recipe: recipe)
        recipe.reload
      end

      it "contains correct ingredients" do
        parsed_ingredients = parsed_json["recipeIngredient"]
        expected_ingredients = [
          "10 g carrot, finely chopped",
          "10 g carrot, finely chopped"
        ]

        expected_ingredients.each do |ingredient|
          expect(parsed_ingredients).to include(ingredient)
        end
      end

      it "contains correct method steps" do
        parsed_method_steps = parsed_json["recipeInstructions"]
        expected_method_steps = [
          "Peel and finely chop the onions",
          "Peel and finely chop the onions"
        ]

        expected_method_steps.each do |method_step|
          expect(parsed_method_steps).to include(method_step)
        end
      end
    end
  end
end

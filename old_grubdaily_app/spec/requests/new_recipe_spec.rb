require "rails_helper"

RSpec.describe "Importing a new Recipe" do
  context "from a YAML file" do
    let(:recipe_yaml_path) { "lib/yaml_recipes/dal_makhani.yaml" }
    let(:yaml_content) { File.read(Rails.root.join(recipe_yaml_path)) }

    let(:create_recipe) do
      post recipe_imports_create_path, params: { content: yaml_content }
    end

    it "renders the new recipe form" do
      get new_recipe_path

      expect(response).to be_successful
      expect(response.body).to match("New Recipe")
    end

    it "creates an (unpublished) recipe" do
      expect{ create_recipe }.to change{ Recipe.count }.by(1)
      expect(Recipe.find_by_title("Dal Makhani").published_at).to be_nil
    end

    it "creates ingredient sets" do
      expect{ create_recipe }.to change{ IngredientSet.count }.by(2)
    end

    it "creates ingredient entries" do
      expect{ create_recipe }.to change{ IngredientEntry.count }.by(15)
    end

    it "creates method steps" do
      expect{ create_recipe }.to change{ MethodStep.count }.by(3)
    end
  end
end

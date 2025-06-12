require 'rails_helper'

RSpec.describe RecipeImporter, type: :model do
  let(:content) { File.read("spec/test_data/test_recipe.yaml") }
	let(:importer) { RecipeImporter.new(content) }
  let(:recipe) { FactoryBot.create(:recipe) }

  before { importer.populate_fields }

  context "the recipe info" do
    it "should have the correct attributes" do
      expect(importer.title).to eq "Test Recipe"
      expect(importer.total_time).to eq "PT2D"
      expect(importer.recipe_type).to eq "jam"
      expect(importer.category).to eq "bread"
      expect(importer.tags).to eq "bacon, comte"
      expect(importer.summary).to eq "This is a summary"
    end
  end

  context "the introduction" do
  	it "should be present" do
  		expect(importer.introduction).to be_present
  	end
  end

  context "ingredient sets" do
  	it "should be present" do
  		expect(importer.ingredient_sets).to be_present
  	end
  end

  context "the method steps" do
  	it "should be present" do
  		expect(importer.method_steps).to be_present
  	end
	end

  context "#save_recipe" do
    it "should save a valid recipe to the database" do
      fake_response = double("Response", code: 200)
      allow(HTTParty).to receive(:get).and_return(fake_response)

      id = importer.save_recipe
      recipe = Recipe.find(id)
      expect(recipe).to be_valid
    end

    it "should save tags" do
      id = importer.save_recipe
      recipe = Recipe.find(id)

      expect(recipe.tags.first).to be_a(Tag)
      expect(recipe.tags.map(&:name)).to eq(["bacon", "comte"])
    end
  end

  context "#save_ingredients" do
    let(:recipe_id) { importer.save_recipe }

    it "should save ingredients" do
      expect { importer.save_ingredients(recipe_id) }
        .to change { IngredientSet.count }.by(1)
        .and change { IngredientEntry.count }.by(2)
    end
  end

  context "#save_method_steps" do
    let(:recipe_id) { importer.save_recipe }

    it "should save 2 method steps" do
      expect { importer.save_method_steps(recipe_id) }
        .to change { MethodStep.count }.by(2)
    end
  end
end

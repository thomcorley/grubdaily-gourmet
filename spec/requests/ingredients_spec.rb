require 'rails_helper'

RSpec.describe "Ingredients", type: :request do

  let(:ingredient_name) { 'carrot' }

  before(:each) do
    # Stub the class method on Nutrition::Api to prevent real HTTP calls
    allow(Nutrition::Api).to receive(:get_json).and_return({
      calories: { amount: 34.0, unit: "kcal" },
      total_fat: { amount: 0.2, unit: "g" },
      saturated_fat: { amount: 0.0, unit: "g" },
      protein: { amount: 0.8, unit: "g" },
      sodium: { amount: 57, unit: "mg" },
      potassium: { amount: 30, unit: "mg" },
      cholesterol: { amount: 0, unit: "mg" },
      carbohydrates: { amount: 8.3, unit: "g" },
      fibre: { amount: 3.0, unit: "g" },
      sugar: { amount: 3.4, unit: "g" }
    }.to_json)
  end

  describe "GET /ingredients" do
    it "returns a successful response" do
      get ingredients_path
      expect(response).to have_http_status(200)
    end

    it "displays a list of ingredients" do
      ingredients = FactoryBot.create_list(:ingredient, 3)
      get ingredients_path

      ingredients.each do |ingredient|
        expect(response.body).to include(ingredient.name)
      end
    end
  end

  describe "GET /ingredients/:id" do
    it "returns a successful response" do
      ingredient = FactoryBot.create(:ingredient)
      get ingredient_path(ingredient)
      expect(response).to have_http_status(200)
    end

    context 'for any ingredient name' do
      let(:ingredient_name) { 'Test Ingredient' }

      it "displays the ingredient's details" do
        ingredient = FactoryBot.create(:ingredient, name: 'Test Ingredient')
        get ingredient_path(ingredient)
        expect(response.body).to include("Test ingredient")
      end
    end
  end

  describe "POST /ingredients" do
    it "creates a new ingredient with valid parameters" do
      ingredient_params = FactoryBot.attributes_for(:ingredient)
      post ingredients_path, params: { ingredient: ingredient_params }
      expect(response).to redirect_to(ingredient_path(Ingredient.last))
    end

    it "renders new template with invalid parameters" do
      post ingredients_path, params: { ingredient: { name: '' } }
      expect(response).to render_template(:new)
    end
  end
end

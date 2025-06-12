require 'rails_helper'

RSpec.describe "Ingredients", type: :request do

  let(:ingredient_name) { 'carrot' }

  before(:each) { stub_nutrition_request(ingredient_name) }

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

  def stub_nutrition_request(ingredient_name)
    url = "https://api.api-ninjas.com/v1/nutrition?query=#{ingredient_name}"

    headers = {
      headers: {
        "X-Api-Key"=> Nutrition::Api::KEY
      }
    }

    body = [{
      name: "carrot",
      calories: 34.0,
      serving_size_g: 100.0,
      fat_total_g: 0.2,
      fat_saturated_g: 0.0,
      protein_g: 0.8,
      sodium_mg: 57,
      potassium_mg: 30,
      cholesterol_mg: 0,
      carbohydrates_total_g: 8.3,
      fiber_g: 3.0,
      sugar_g: 3.4
    }]

    allow(HTTParty).to receive(:get).with(url, headers).and_return(body)
  end
end

require "rails_helper"

RSpec.describe RecipesController do
  let(:recipe) { FactoryBot.create(:recipe) }

  describe "GET #publish" do
    it "assigns @recipe" do
      get :publish, params: { id: recipe.id }
      expect(response).to have_http_status(:found)
      expect(assigns(:recipe)).to eq(recipe)
    end

    it "sets `published_at` on the recipe" do
      get :publish, params: { id: recipe.id }
      expect(assigns(:recipe).published_at).to be_present
    end
  end
end

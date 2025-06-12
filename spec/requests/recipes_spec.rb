# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Recipes" do
  let(:recipe) { create(:recipe) }

  it "renders the Recipe show page" do
    get recipe_path(recipe)
    expect(response).to be_successful
  end

  it "renders using the parameterised path" do
    get recipe.permalink
    expect(response).to be_successful
  end

  context "with no images attached" do
    let(:placeholder_image) { /src="\/images\/placeholder.*\.jpg"/ }
    before { recipe.image.purge }

    it "renders with a placeholder image" do
      get recipe_path(recipe)
      expect(response).to be_successful
      expect(response.body).to match(placeholder_image)
    end
  end
end

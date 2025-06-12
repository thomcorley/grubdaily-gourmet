require 'rails_helper'

RSpec.describe IngredientSet, type: :model do
  context "ingredient set creation" do
    let(:ingredient_set) { FactoryBot.build(:ingredient_set) }

    it "should have a title of maximum 30 characters length" do
      ingredient_set.title += "a" * 30
      expect(ingredient_set).to be_invalid
    end
  end
end

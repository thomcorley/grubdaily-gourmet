require 'rails_helper'

RSpec.describe IngredientsProcessor, type: :model do
	let(:ingredient_sets) { [ {:INSERT_TITLE=>["140g risotto rice", "1 small onion, finely chopped"]}, nil, nil ] }
	let(:processor) { described_class.new(ingredient_sets) }

  context "#params_for_ingredient_sets" do
    it "should return an array" do
      expect(processor.params_for_ingredient_sets(1)).to be_a Array
    end

    it "should return an array of hashes with keys :title, :position, :recipe_id" do
      ingredient_set = processor.params_for_ingredient_sets(1).first
      keys = processor.params_for_ingredient_sets(1).first.keys

      expect(ingredient_set).to be_a Hash
      expect(keys).to eq [:title, :position, :recipe_id]
    end
  end
end

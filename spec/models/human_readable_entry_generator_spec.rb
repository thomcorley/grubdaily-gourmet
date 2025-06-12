require 'rails_helper'
require_relative '../test_data/human_readable_ingredient_entries.rb'

RSpec.describe HumanReadableEntryGenerator,
type: :model do
  describe "#generate" do
    context "parsing a variety of ingredient entry data" do
      test_data = IngredientEntryTestData::ENTRIES

      test_data.each do |hash|
        it "'#{hash[:expected_output]}' has a human readable string equal to the expected one" do

          entry_params = {
            quantity: hash[:params][0],
            unit: hash[:params][1],
            size: hash[:params][2],
            ingredient_name: hash[:params][3],
            modifier: hash[:params][4],
            quantityless: hash[:params][5],
            original_string: hash[:expected_output]
          }
          entry = IngredientEntry.create(entry_params)

          generated_output = described_class.new(entry).generate
          expected_output = hash[:expected_output]

          expect(generated_output).to eq(expected_output)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { FactoryBot.build(:recipe) }

  context "Recipe creation" do
    it "should have a vaild title" do
      expect(recipe.title.length).to be < 40
      expect(recipe.title).to be_present
    end

    it "should have a valid summary" do
      expect(recipe.summary).to be_present
      expect(recipe.summary.length).to be < 150
    end

    it "should have a time value in valid ISO 8601 format" do
      expect(recipe.total_time).to match Recipe::TIME_FORMAT_REGEX
    end

    it "should have a value for either :serves or :makes" do
      recipe.assign_attributes(serves: nil, makes: nil, makes_unit: nil)
      expect(recipe).to be_invalid
    end

    it "should have a value for :makes_unit if :makes is present" do
      recipe.update(serves: nil, makes: 1, makes_unit: nil)
      expect(recipe).to be_invalid
    end

    it "should have a numerical value greater than 0 for :serves" do
      recipe.update(**{serves: 1, makes: nil, makes_unit: nil})
      expect(recipe.serves).to be > 0
    end

    it "should have a numerical value greater than 0 for :makes" do
      attrs = { serves: 0, makes: 0, makes_unit: "loaves" }
      recipe.update(**attrs)
      expect(recipe).to be_invalid
    end

    it "should have a non-numerical value for :makes_unit" do
      expect(recipe.makes_unit.is_a?(Numeric)).to eq false
    end
  end

  describe "#image" do
    it "should return the asset name" do
      expect(recipe.image).to be_a(ActiveStorage::Attached::One)
    end
  end

  describe "#excerpt" do
    let(:expected_excerpt) {
      "<p>An old French classic, this is truly an old school soup. It is rich and dark with beef stock and, if made correctly, should be very thick. ...</p>\n"
    }

    it "returns the first part of the introduction" do
      expect(recipe.excerpt).to eq expected_excerpt
    end
  end

  describe "#publish!" do
    let(:now) { "Wed, 28 Jul 2021 07:23:46.867401000 UTC +00:00" }
    before { allow(DateTime).to receive(:now).and_return(now) }

    it "sets the `published_at` attribute" do
      recipe.publish!
      expect(recipe.published_at).to eq(now)
    end
  end

  describe "#unpublish!" do
    let(:now) { "Wed, 28 Jul 2021 07:23:46.867401000 UTC +00:00" }
    before { allow(DateTime).to receive(:now).and_return(now) }

    it "clears the `published_at` attribute" do
      recipe.unpublish!
      expect(recipe.published_at).to eq(nil)
    end
  end
end

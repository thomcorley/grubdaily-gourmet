require 'rails_helper'

RSpec.describe IngredientEntryProcessor, type: :model do

  context "parsing '1 carrot'" do
    let(:processor) { described_class.new("1 carrot", 1) }

    it "has a quantity of 1" do
      expect(processor.get_quantity).to eq 1
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of carrot" do
      expect(processor.get_ingredient).to eq "carrot"
    end
  end

  context "parsing '10g carrots, diced'" do
    let(:processor) { described_class.new("10g carrots, diced", 1) }

    it "has a quantity of 10" do
      expect(processor.get_quantity).to eq 10
    end

    it "has a unit of 'g'" do
      expect(processor.get_unit).to eq "g"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of 'diced'" do
      expect(processor.get_modifier).to eq "diced"
    end

    it "has an ingredient of carrots" do
      expect(processor.get_ingredient).to eq "carrots"
    end
  end

  context "parsing '25 large tomatoes, peeled and chopped'" do
    let(:processor) { described_class.new("25 large tomatoes, peeled and chopped", 1) }

    it "has a quantity of 25" do
      expect(processor.get_quantity).to eq 25
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of 'large'" do
      expect(processor.get_size).to eq "large"
    end

    it "has a modifier of 'peeled and chopped'" do
      expect(processor.get_modifier).to eq "peeled and chopped"
    end

    it "has an ingredient of tomatoes" do
      expect(processor.get_ingredient).to eq "tomatoes"
    end
  end

  context "parsing '3 handfuls basil, leaves picked'" do
    let(:processor) { described_class.new("3 handfuls basil, leaves picked", 1) }

    it "has a quantity of 3" do
      expect(processor.get_quantity).to eq 3
    end

    it "has a unit of 'handful'" do
      expect(processor.get_unit).to eq "handful"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of 'leaves picked'" do
      expect(processor.get_modifier).to eq "leaves picked"
    end

    it "has an ingredient of 'basil" do
      expect(processor.get_ingredient).to eq "basil"
    end
  end

  context "parsing '3 large cloves garlic, chopped'" do
    let(:processor) { described_class.new("3 large cloves garlic, chopped", 1) }

    it "has a quantity of 3" do
      expect(processor.get_quantity).to eq 3
    end

    it "has a unit of 'large clove" do
      expect(processor.get_unit).to eq "large clove"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of 'chopped'" do
      expect(processor.get_modifier).to eq "chopped"
    end

    it "has an ingredient of 'garlic" do
      expect(processor.get_ingredient).to eq "garlic"
    end
  end

  context "parsing '1 generous pinch of salt'" do
    let(:processor) { described_class.new("a generous pinch of salt", 1) }

    it "has a quantity of 1" do
      expect(processor.get_quantity).to eq 1
    end

    it "has a unit of 'generous pinch" do
      expect(processor.get_unit).to eq "generous pinch"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'salt'" do
      expect(processor.get_ingredient).to eq "salt"
    end
  end

  context "parsing 'vegetable oil, for frying'" do
    let(:processor) { described_class.new("vegetable oil, for frying", 1) }

    it "has a quantity of nil" do
      expect(processor.get_quantity).to be_nil
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of 'for frying'" do
      expect(processor.get_modifier).to eq "for frying"
    end

    it "has an ingredient of 'vegetable oil'" do
      expect(processor.get_ingredient).to eq "vegetable oil"
    end
  end

  context "parsing '2 small cloves of garlic'" do
    let(:processor) { described_class.new("2 small cloves of garlic", 1) }

    it "has a quantity of 2" do
      expect(processor.get_quantity).to eq 2
    end

    it "has a unit of 'small clove'" do
      expect(processor.get_unit).to eq "small clove"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'garlic'" do
      expect(processor.get_ingredient).to eq "garlic"
    end
  end

  context "parsing '750g cavolo nero (black kale)'" do
    let(:processor) { described_class.new("750g cavolo nero (black kale)", 1) }

    it "has a quantity of 750" do
      expect(processor.get_quantity).to eq 750
    end

    it "has a unit of 'g'" do
      expect(processor.get_unit).to eq "g"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of 'black kale'" do
      expect(processor.get_modifier).to eq "black kale"
    end

    it "has an ingredient of 'cavolo nero'" do
      expect(processor.get_ingredient).to eq "cavolo nero"
    end
  end

  context "parsing '1 teaspoon of extra virgin olive oil'" do
    let(:processor) { described_class.new("a teaspoon of extra virgin olive oil", 1) }

    it "has a quantity of 1" do
      expect(processor.get_quantity).to eq 1
    end

    it "has a unit of 'teaspoon'" do
      expect(processor.get_unit).to eq "teaspoon"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'extra virgin olive oil'" do
      expect(processor.get_ingredient).to eq "extra virgin olive oil"
    end
  end

  context "parsing '1 pinch of ground asafoetida'" do
    let(:processor) { described_class.new("a pinch of ground asafoetida", 1) }

    it "has a quantity of 1" do
      expect(processor.get_quantity).to eq 1
    end

    it "has a unit of 'pinch'" do
      expect(processor.get_unit).to eq "pinch"
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'ground asafoetida'" do
      expect(processor.get_ingredient).to eq "ground asafoetida"
    end
  end

  context "parsing 'sea salt and freshly cracked black pepper'" do
    let(:processor) { described_class.new("sea salt and freshly cracked black pepper", 1) }

    it "has a quantity of nil" do
      expect(processor.get_quantity).to be_nil
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'sea salt and freshly cracked black pepper'" do
      expect(processor.get_ingredient).to eq "sea salt and freshly cracked black pepper"
    end
  end

  context "parsing '1/2 leek'" do
    let(:processor) { described_class.new("1/2 leek", 1) }

    it "has a quantity of 0.5" do
      expect(processor.get_quantity).to eq(0.5)
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'leek'" do
      expect(processor.get_ingredient).to eq "leek"
    end
  end

  context "a handful of red seedless grapes" do
    let(:processor) { described_class.new("a handful of red seedless grapes", 1) }

    it "has a quantity of 1" do
      expect(processor.get_quantity).to eq(1)
    end

    it "has a unit of 'handful'" do
      expect(processor.get_unit).to eq("handful")
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to be_nil
    end

    it "has an ingredient of 'red seedless grapes'" do
      expect(processor.get_ingredient).to eq "red seedless grapes"
    end
  end

  context "10 carrots, cut into 5mm dice" do
    let(:processor) { described_class.new("10 carrots, cut into 5mm dice", 1) }

    it "has a quantity of 10" do
      expect(processor.get_quantity).to eq(10)
    end

    it "has a unit of nil" do
      expect(processor.get_unit).to be_nil
    end

    it "has a size of nil" do
      expect(processor.get_size).to be_nil
    end

    it "has a modifier of nil" do
      expect(processor.get_modifier).to eq("cut into 5mm dice")
    end

    it "has an ingredient of 'carrots'" do
      expect(processor.get_ingredient).to eq "carrots"
    end
  end
end

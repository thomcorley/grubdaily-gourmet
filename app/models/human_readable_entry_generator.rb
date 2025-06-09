class HumanReadableEntryGenerator
  attr_reader :ingredient_entry, :quantity, :unit, :modifier, :ingredient, :size, :original_string

  METRIC_UNITS = ["g", "kg", "mg", "l", "ml"]
  IRREGULAR_UNITS_REGULAR = ["wedge", "cloves", "clove", "bulb", "bulbs", "head", "heads", "handfuls", "handful", "glassful", "glassfuls"]
  IRREGULAR_UNITS_LARGE = IRREGULAR_UNITS_REGULAR.map{ |unit| "large #{unit}"}
  IRREGULAR_UNITS_SMALL = IRREGULAR_UNITS_REGULAR.map{ |unit| "small #{unit}"}
  IRREGULAR_UNITS = IRREGULAR_UNITS_REGULAR + IRREGULAR_UNITS_SMALL + IRREGULAR_UNITS_LARGE

  def initialize(ingredient_entry)
    @ingredient_entry = ingredient_entry
    set_instance_variables
  end

  def generate
    return original_string if special_entry? || ingredient_entry.quantityless?
    get_quantity +
    get_unit +
    get_size +
    get_ingredient +
    get_modifier
  end

  private

  def get_quantity
    return "" if quantity.nil?
    return fractional_quantity if quantity_should_be_a_fraction?
    # This ensures we display "5" instead of "5.0", for example
    return quantity.to_i.to_s if quantity.to_f.floor == quantity.to_f

    quantity
  end

  def get_unit
    return "" if blank?(unit)
    return " #{unit.to_s}" unless unit_is_irregular?

    quantity.to_i > 1 ? " #{unit.pluralize.to_s}" : " #{unit.singularize.to_s}"
  end

  def get_size
    blank?(size) ? "" : " #{size}"
  end

  def get_ingredient
    " #{ingredient.to_s}"
  end

  def get_modifier
    if ingredient_entry.original_string =~ /\(/
      mod = " (#{modifier})"
    else
      mod = ", #{modifier}"
    end

    blank?(modifier) ? "" : mod
  end

  def blank?(attribute)
    attribute.nil? || attribute == ""
  end

  def set_instance_variables
    @quantity = ingredient_entry.quantity.to_f.to_s
    @unit = ingredient_entry.unit
    @modifier = ingredient_entry.modifier
    @ingredient = ingredient_entry.ingredient_name
    @size = ingredient_entry.size
    @original_string = ingredient_entry.original_string
  end

  def unit_is_metric?
    METRIC_UNITS.include?(unit)
  end

  def unit_is_irregular?
    IRREGULAR_UNITS.include?(unit)
  end

  def ingredient_singular_with_unit?
    SINGULAR_WITH_UNIT.include?(ingredient)
  end

  def special_entry?
    IngredientEntryProcessor::SPECIAL_ENTRIES.include?(original_string.strip)
  end

  def quantity_should_be_a_fraction?
    %w(0.5 0.25 0.75 0.125 0.333 0.666).include?(quantity)
  end

  def fractional_quantity
    decimal_to_fraction_map = {
      "0.5"   => "½",
      "0.25"  => "¼",
      "0.75"  => "¾",
      "0.125" => "⅛",
      "0.333" => "⅓",
      "0.666" => "⅔",
    }

    decimal_to_fraction_map[quantity]
  end
end

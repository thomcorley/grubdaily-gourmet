# This class is concerned with taking the inputted string
# from the RecipeImport, eg: "10 g tomatoes, chopped" and
# parsing it into the quantity, unit etc. The reverse process
# is handled by HumanReadableEntryGenerator
class IngredientEntryProcessor

	SIZES = %w(small medium large generous)

	UNIT_REGEX = /[0-9]+([a-z]+)\s/

	SPECIAL_ENTRIES = [
		"vegetable oil, for frying",
		"vegetable oil, for cooking",
		"sea salt and freshly cracked black pepper",
		"sea salt and cracked black pepper",
		"sea salt",
		"extra virgin olive oil",
		"olive oil",
		"rapeseed oil",
	]

	def initialize(ingredient_entry_string, ingredient_set_id)
		@ingredient_entry_string = ingredient_entry_string
		@ingredient_set_id = ingredient_set_id
	end

	# Returns a hash of params to create an IngredientEntry
	def parse
		{
			quantity: get_quantity,
			unit: get_unit,
			size: get_size,
			ingredient_name: get_ingredient,
			modifier: get_modifier,
			original_string: @ingredient_entry_string,
			ingredient_set_id: @ingredient_set_id
		}
	end


	def get_modifier
		# Handles the case where there are brackets instead of
		# a comma. Assumes there isn't both a comma and brackets.
		if @ingredient_entry_string.match(/(\(.+\))/)
			return @ingredient_entry_string.match(/\((.+)\)/)[1]
		end

		array = @ingredient_entry_string.split(",")
		array.count > 1 ? array.last.strip : nil
	end

	def get_quantity
		return 1 if entry_array.first == "a"
		return nil if special_exception

		# Handles '1g pepper', for example
		quantity_and_unit = entry_array.select{ |i| i =~ /[0-9]+/ }.first

		# Handles '1/2 leek', for example
		return Rational(quantity_and_unit).to_f if quantity_and_unit =~ /[1-9]\/[1-9]/

		if quantity_and_unit
			quantity_and_unit.match(/[0-9]+/)[0].to_f
		else
			nil
		end
	end

	def get_unit
		entry = ingredient_entry_string_without_modifier

		return nil if special_exception
		# If there's a spaced unit (singular or plural) that
		# matches in the entry string, this is the unit.
		unit = nil

		Units::SPACED.each do |i|
			unit = entry.match(i)[0] if entry.match?(i)
		end

		return unit if unit

		# The unit should be space separated, so we can grab it
		# by splitting the string and match using the array of known units
		array = entry.split(" ")
		unit = array.select{ |i| Units::ALL.include?(i) }.first

		return unit if unit

		# Or, the unit might be suffixed to a number.
		# Match this and use a group to separate the unit from the numerical part.
		# Otherwise, there's no unit so just return nil
		matcher = entry.match(UNIT_REGEX)
		matcher ? unit = matcher[1] : unit = nil
	end

	def get_size
		return nil if special_exception
		size = nil
		entry_string_minus_unit = remove_unit_from(@ingredient_entry_string)

		SIZES.each do |s|
			matcher = entry_string_minus_unit.match(s)
			size = matcher[0] if matcher
		end
		size
	end

	def get_ingredient
		string = entry_array.join(" ")

		if get_quantity
			string = string.sub(/^[0-9 \/]+/, "")
			string = string.sub(/^a\s/, "")
		end

		string = string.sub(get_size, "") if get_size

		string = remove_unit_from(string)

		# TODO: change this!!!
		# This handles the case where there's brackets
		# eg: cavolo nero (black kale)
		if string =~ /\(/
			string = string.split("(").first
		end
		string.strip
	end

	private

	# Take an entry string and remove the unit from it.
	def remove_unit_from(entry_string)
		# If there's no unit, just return the unchanged string
		return entry_string unless get_unit
		# If there's a singular unit, remove it and return the result
		if entry_string.match?(get_unit + " ")
			entry_string.sub(get_unit, "")
		else
			entry_string.sub(get_unit.pluralize, "")
		end
	end

	# This is an array of the components of the entry string
	# split on spaces, minus the modifier
	def entry_array
		a = @ingredient_entry_string.split(",").first.split
		a.delete("of")
		return a
	end

	def singularize(unit_string)
		if unit_string =~ /clove/
			return "clove"
		else
			unit_string.singularize
		end
	end

	def special_exception
		SPECIAL_ENTRIES.include?(@ingredient_entry_string)
	end

	def ingredient_entry_string_without_modifier
		entry = @ingredient_entry_string

		if entry =~ /\(/
			entry.split("(").first.strip
		elsif entry =~ /,/
			entry.split(",").first.strip
		else
			entry
		end
	end
end

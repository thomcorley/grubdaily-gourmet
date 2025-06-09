class RecipeImporter
	include ActiveModel::AttributeMethods
	include ActiveModel::AttributeAssignment

	require "yaml"

	attr_accessor  :content, :title, :total_time, :serves, :makes, :makes_unit, :recipe_type, :category, :tags, :summary,
						 :introduction, :ingredient_sets, :method_steps, :content_hash, :published


	def initialize(content)
		@content = content
		@content_hash = YAML.load(content).deep_symbolize_keys
	end

	def populate_fields
		self.assign_attributes(attributes)
	end

	def attributes
		{
			title: content_hash[:title],
			total_time: content_hash[:total_time],
			serves: content_hash[:serves],
			makes: makes_quantity,
			makes_unit: makes_unit,
			recipe_type: content_hash[:type],
			category: content_hash[:category],
			tags: content_hash[:tags],
			summary: content_hash[:summary],
			content: content_hash[:introduction].join("\n"),
			ingredient_sets: ingredient_sets,
			method_steps: content_hash[:method_steps],
			published: true,
		}
	end

	def ingredient_sets
		[content_hash[:first_ingredient_set], content_hash[:second_ingredient_set], content_hash[:third_ingredient_set]]
	end

	# This should be an array of method steps
	def method_steps
		content_hash[:method_steps]
	end

	def save_recipe
		recipe_params = attributes.slice(:title, :total_time, :serves, :makes, :makes_unit, :category, :recipe_type)
		entry_params = attributes.slice(:title, :summary, :content)

    entry = Entry.create!(entry_params.merge({entryable: Recipe.create!(recipe_params)}))
    entry.tags = attributes[:tags]
		entry.entryable.id
	end

	def save_ingredients(recipe_id)
		processor = IngredientsProcessor.new(ingredient_sets)

		processor.params_for_ingredient_sets(recipe_id).each_with_index do |ingredient_set_params, i|
			ingredient_set = IngredientSet.create!(ingredient_set_params)

			processor.params_for_ingredient_entries(ingredient_set.id, i).each do |ingredient_entry_params|
				ingredient_entry = IngredientEntry.create!(ingredient_entry_params)
			end
		end
	end

	def save_method_steps(recipe_id)
		method_steps.each_with_index do |m, i|
			MethodStep.create!(position: i + 1, description: m, recipe_id: recipe_id)
		end
	end

	private

	def makes_unit
		content_hash[:makes]&.split&.last
	end

	def makes_quantity
		content_hash[:makes]&.split&.first
	end
end

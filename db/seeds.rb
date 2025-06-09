# frozen_string_literal: true
class RecipeSeeder
  def self.seed
    count = 0
    Dir.glob("lib/yaml_recipes/*.yaml") do |yaml_filename|
      filepath = Rails.root.join(yaml_filename)
      yaml_file = File.read(filepath)

      ActiveRecord::Base.transaction do
        importer = RecipeImporter.new(yaml_file)
        recipe_id = importer.save_recipe
        importer.save_ingredients(recipe_id)
        importer.save_method_steps(recipe_id)

        recipe = Recipe.find(recipe_id)
        recipe_image = "#{recipe.image_name}.jpg"

        recipe.image.attach(
          io: File.open("#{Rails.root.to_s}/app/assets/images/#{recipe.image_name}.jpg"),
          filename: "#{recipe.image_name}.jpg"
        )

        recipe.save!

        Recipe.update_all(published_at: Date.today)

        count += 1
        puts "Recipe created: #{yaml_filename}"
      rescue Psych::SyntaxError => e
        puts "Error parsing YAML file #{yaml_filename}. Message: #{e}"
      rescue StandardError => e
        puts "Recipe (#{yaml_filename}) could not be created: #{e}"
      end
    end

    puts "Imported #{count} recipes"

    puts "Attaching images to recipes..."

    Recipe.all.each do |recipe|
      recipe.image.attach(
        io: File.open("#{Rails.root.to_s}/app/assets/images/#{recipe.image_name}.jpg"),
        filename: "#{recipe.image_name}.jpg"
      )
      puts "Attached image for #{recipe.title}"
    rescue StandardError
      next
    end
  end
end

RecipeSeeder.seed if Rails.env == "development"

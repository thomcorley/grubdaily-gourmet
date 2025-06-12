# frozen_string_literal: true
require 'open-uri'
require 'json'

puts "Destroying existing recipes, entries, and tags..."
Recipe.destroy_all
Entry.destroy_all
Tag.destroy_all
puts "Existing data cleared."

url = 'https://api.grubdaily.com/recipes'
puts "Fetching recipes from #{url}..."

begin
  json_data = URI.open(url).read
  recipes_data = JSON.parse(json_data)
rescue OpenURI::HTTPError => e
  puts "Error fetching recipes: #{e.message}. The API might be down."
  exit
rescue JSON::ParserError => e
  puts "Error parsing JSON response: #{e.message}."
  exit
end

puts "Found #{recipes_data.count} recipes. Starting import..."

recipes_data.each do |recipe_data|
  next unless recipe_data['published']

  Recipe.transaction do
    puts "Processing recipe: #{recipe_data['title']}"

    entry_content = recipe_data['introduction']
    entry_excerpt = recipe_data['summary']
    entry_slug = recipe_data['slug']

    tags = []
    if recipe_data['category'].present?
      tags << Tag.find_or_create_by!(name: recipe_data['category'].downcase)
    end
    if recipe_data['recipe_type'].present?
      tags << Tag.find_or_create_by!(name: recipe_data['recipe_type'].downcase)
    end

    entry = Entry.create!(
      content: entry_content,
      summary: entry_excerpt,
      slug: entry_slug,
      tags: tags.uniq
    )

    recipe = entry.create_entryable!(
      type: 'Recipe',
      title: recipe_data['title'],
      total_time: recipe_data['total_time'],
      serves: recipe_data['serves'],
      makes: recipe_data['makes'],
      makes_unit: recipe_data['makes_unit'],
      published_at: recipe_data['published_at'],
      marked_for_promotion_at: recipe_data['marked_for_promotion_at']
    )

    image_url = recipe_data.dig('images', 'main', 'large')
    if image_url.present? && image_url.start_with?('http')
      begin
        puts "  Attaching image from #{image_url}..."
        image_file = URI.open(image_url)
        recipe.image.attach(
          io: image_file,
          filename: File.basename(URI.parse(image_url).path)
        )
      rescue StandardError => e
        puts "  Could not attach image for #{recipe.title}. Error: #{e.message}"
      end
    else
      puts "  No valid image found for #{recipe.title}."
    end

    recipe_data['ingredient_sets'].sort_by { |is| is['position'] }.each do |set_data|
      ingredient_set = recipe.ingredient_sets.create!(
        title: set_data['title'],
        position: set_data['position']
      )

      set_data['ingredient_entries'].each do |entry_data|
        ingredient_set.ingredient_entries.create!(
          quantity: entry_data['quantity'],
          unit: entry_data['unit'],
          size: entry_data['size'],
          modifier: entry_data['modifier'],
          original_string: entry_data['original_string'],
          ingredient_name: entry_data['ingredient_name']
        )
      end
    end

    recipe_data['method_steps'].sort_by { |ms| ms['position'] }.each do |step_data|
      recipe.method_steps.create!(
        position: step_data['position'],
        description: step_data['description']
      )
    end
  end
end

puts "Seed import complete."

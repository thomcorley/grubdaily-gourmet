module HomeHelper
  def recipe_carousel_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "ItemList",
      itemListElement: recipe_items
    }).html_safe
  end

  def recipe_items
    recipes = @entries_for_carousel.select{ |entry| entry.is_a?(Recipe) }

    recipes.map.with_index(1) do |recipe, index|
      {
        "@type":"ListItem",
        "position": index,
        "url": "https://grubdaily.com#{recipe.permalink}"
      }
    end
  end
end

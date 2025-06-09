module RecipeHelper
  def serves_or_makes_text
    @recipe.serves_or_makes_text
  end

  def recipe_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "Recipe",
      name: @recipe.title,
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: recipe_image,
      datePublished: @recipe.created_at,
      totalTime: @recipe.total_time,
      recipeYield: @recipe.serves_or_makes,
      description: @recipe.summary,
      aggregateRating: {
        "@type": "AggregateRating",
        ratingValue: @recipe.rating_value,
        ratingCount: @recipe.rating_count
      },
      recipeIngredient: @recipe.ingredients_array,
      recipeInstructions: @recipe.method_steps_array,
      publisher: {
        "@type": "Organization",
        name: "grubdaily",
        logo: {
          "@type": "ImageObject",
          url: "http://www.grubdaily.com/favicon_large.jpg"
        }
      }
    }).html_safe
  end

  def recipe_image
    url = @recipe.image.attached? ? rails_storage_proxy_url(@recipe.image.variant(resize_to_limit: [300, 300], format: :png)) : nil

    return unless url

    url.sub('.webp', '')
  end
end

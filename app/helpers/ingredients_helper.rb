module IngredientsHelper
  def ingredient_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "Article",
      headline: "#{@ingredient.name.capitalize} – Culinary History, Botanical Notes and Nutrition",
      url: "#{request.base_url}/ingredient/#{@ingredient.name.downcase}",
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: ingredient_image,
      datePublished: @ingredient.created_at,
      articleBody: @ingredient.content,
      publisher: {
        "@type": "Organization",
        name: "grubdaily",
        logo: {
          "@type": "ImageObject",
          url: "http://www.grubdaily.com/favicon_large.jpg"
        }
      },
      wordCount: @ingredient.content.split(' ').count
    }).html_safe
  end

  def ingredient_image
    @ingredient.image.attached? ? rails_storage_proxy_url(@ingredient.image.variant(resize_to_limit: [300, 300])) : nil
  end

  # Generate a string for displaying the amount for
  # the nutrient, eg: '7 mg', taking into account zeros
  #
  # data: (Hash) eg: {'amount' => 10, 'unit' => 'g'}
  #
  # Returns String
  def nutrition_quantity(data, serves=nil)
    return '0' if data['amount'].blank? || data['amount'].zero?

    amount = data['amount'].round(1)
    unit = data['unit']
    round_to = amount < 1.0 ? 1 : 0
    amount = amount.round(round_to)

    amount = amount / serves if serves
    "#{amount} #{unit unless amount.zero?}"
  end

  # Provide a percentage value of the recommended daily
  # amount for the given nutrient
  #
  # nutrient: (String) eg: 'calories'
  # data: (Hash) eg: {'amount' => 10, 'unit' => 'g'}
  #
  # Returns Float
  def nutrition_daily_value(nutrient, data, serves=nil)
    return '0%' if data['amount'].blank? || data['amount'].zero?

    amount = if serves
      data['amount'] / serves
    else
      data['amount']
    end

    daily_values = Nutrition.daily_values
    recommended = daily_values[nutrient.to_sym]

    return "n/a" unless recommended || recommended&[:unit] == data['unit']

    percentage = (amount.to_f / recommended[:amount].to_f) * 100
    round_to = percentage < 1.0 ? 1 : 0

    "#{percentage.round(round_to)}%"
  end
end

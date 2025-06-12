module IngredientEntriesHelper
  def ingredient_entry_tag(ingredient_entry, &block)
    ingredient = ingredient_entry.ingredient
    recipe = ingredient_entry.recipe
    entry_name = ingredient_entry.ingredient_name

    link_content = if ingredient
      ingredient_link = content_tag('span',
        content_tag('a', entry_name, { href: friendly_ingredient_path(ingredient.name), target: '_blank' })
      )

      ingredient_entry.human_readable_entry.sub(entry_name, ingredient_link).html_safe
    elsif entry_name == 'peanut caramel'
      peanut_caramel_link = content_tag('span',
        content_tag('a', 'peanut caramel', { href: 'https://www.peanutcaramel.uk', target: '_blank' })
      )

      ingredient_entry.human_readable_entry.sub(entry_name, peanut_caramel_link).html_safe
    elsif recipe
      recipe_link = content_tag('span',
        content_tag('a', entry_name, { href: recipe.permalink, target: '_blank' })
      )

      ingredient_entry.human_readable_entry.sub(entry_name, recipe_link).html_safe
    else
      ingredient_entry.human_readable_entry
    end

    content_tag('li') do
      link_content
    end
  end
end

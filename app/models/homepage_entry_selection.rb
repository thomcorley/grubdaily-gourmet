class HomepageEntrySelection
  def entries_for_carousel
    @entries_for_carousel ||= entries.sort_by{ |entry| entry.published_at }.last(5).reverse
  end

  def recent_recipes
    recipes.reject { |recipe| entries_for_carousel.include?(recipe) }.first(8)
  end

  def recent_blog_posts
    blog_posts.reject { |blog_post| entries_for_carousel.include?(blog_post) }.first(4)
  end

  def recipes
    @recipes ||= Recipe.for_homepage_selection
  end

  def blog_posts
    @blog_posts ||= BlogPost.for_homepage_selection
  end

  private

  def entries
    recipes + blog_posts
  end
end

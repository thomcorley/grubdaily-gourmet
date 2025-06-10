class HomeController < ApplicationController
  def test
    @key = params[:key]
    @code = params[:code]
  end

  def index
    @entries_for_carousel = entry_selection.entries_for_carousel
    @recipes = entry_selection.recent_recipes
    @blog_posts = entry_selection.recent_blog_posts

    fresh_when(last_modified: homepage_last_modified, etag: homepage_etag)
  end

  def about
    fresh_when(last_modified: Time.zone.parse("2024-01-01"))
  end

  def recipe_index
    @recipes = Recipe.published_with_image.order(created_at: :desc).limit(12)
    fresh_when(@recipes)
  end

  def more_recipes
    @page = params[:page] || 1
    offset = @page.to_i * 12

    recipes = Recipe.published_with_image
                    .order(created_at: :desc)
                    .offset(offset)
                    .limit(12)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.append("truncated-recipe-list",
            partial: "shared/entry_list",
            locals: {
              entries: recipes
            }
          ),
          turbo_stream.replace("load-more-button",
            partial: "shared/load_more_button",
            locals: {
              path: more_recipes_path(page: @page.to_i + 1),
              button_text: "Load more recipes"
            }
          )
        ]
      }
    end
  end

  def shop
    fresh_when(last_modified: Time.zone.parse("2024-06-01"))
  end

  def latest_entry
    entries = [ recipes.first, blog_posts.first ]

    if entries.empty?
      redirect_to root_url
    else
      @latest_entry = entries.sort_by{ |entry| entry.published_at }.last

      redirect_to @latest_entry.permalink
    end
  end

  private

  def entry_selection
    HomepageEntrySelection.new
  end

  def recipes
    entry_selection.recipes
  end

  def blog_posts
    entry_selection.blog_posts
  end

  def homepage_last_modified
    [
      Recipe.published.maximum(:updated_at),
      BlogPost.published.maximum(:updated_at)
    ].compact.max || 1.day.ago
  end

  def homepage_etag
    [
      Recipe.published.count,
      BlogPost.published.count,
      Recipe.published.maximum(:updated_at),
      BlogPost.published.maximum(:updated_at)
    ]
  end
end

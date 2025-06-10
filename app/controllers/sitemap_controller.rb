# frozen_string_literal: true
class SitemapController < ApplicationController
  def show
    @entries = Recipe.published + BlogPost.published
    @ingredients = Ingredient.with_content
    @collections = Collection.published

    last_modified = [
      Recipe.published.maximum(:updated_at),
      BlogPost.published.maximum(:updated_at),
      Ingredient.maximum(:updated_at),
      Collection.maximum(:updated_at)
    ].compact.max || 1.day.ago

    fresh_when(last_modified: last_modified)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private

  # def tags
  #   Tag.find_by_sql(recipes_sql) +
  #     Tag.find_by_sql(blog_posts_sql) +
  #     Tag.find_by_sql(digested_reads_sql)
  # end

  # def recipes_sql
  #   %Q(
  #     SELECT tags.id, tags.name, count(recipe_taggings.id) FROM tags
  #     INNER JOIN recipe_taggings
  #       ON recipe_taggings.tag_id = tags.id
  #     GROUP BY tags.id
  #     HAVING count(recipe_taggings.id) > 1
  #   )
  # end

  # def blog_posts_sql
  #   %Q(
  #     SELECT tags.id, tags.name, count(blog_post_taggings.id) FROM tags
  #     INNER JOIN blog_post_taggings
  #       ON blog_post_taggings.tag_id = tags.id
  #     GROUP BY tags.id
  #     HAVING count(blog_post_taggings.id) > 1
  #   )
  # end

  # def digested_reads_sql
  #   %Q(
  #     SELECT tags.id, tags.name, count(digested_read_taggings.id) FROM tags
  #     INNER JOIN digested_read_taggings
  #       ON digested_read_taggings.tag_id = tags.id
  #     GROUP BY tags.id
  #     HAVING count(digested_read_taggings.id) > 1
  #   )
  # end
end

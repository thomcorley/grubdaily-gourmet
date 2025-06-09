# frozen_string_literal: true
class SitemapController < ApplicationController
  caches_page :show

  def show
    @entries = Recipe.published + BlogPost.published
    # @tags = tags.uniq
    @ingredients = Ingredient.with_content
    @collections = Collection.published

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

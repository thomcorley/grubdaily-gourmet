class EntriesController < ApplicationController
  def autocomplete
    @query = params[:q]&.strip
    @entries = matching_entries.uniq.first(10) if @query

    render(
      partial: "shared/autocomplete_entry",
      collection: @entries, as: :entry
    )
  end

  private

  def query_regex
    @query_regex ||= "#{@query}|#{@query.pluralize}|#{@query.singularize}"
  end

  def matching_entries
    entry_scope.where("entries.title ~* '#{query_regex}'") +
      entry_scope.where("tags.name ~* '#{query_regex}'") +
      entry_scope.where("ingredient_entries.ingredient_name ~* '#{query_regex}'")
  end

  def entry_scope
    @entry_scope ||= Entry.distinct
      .published
      .left_outer_joins(:tags)
      .left_outer_joins(recipe: {ingredient_sets: :ingredient_entries})
      .order(published_at: :desc)
  end
end

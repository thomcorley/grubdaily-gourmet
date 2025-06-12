class SearchController < ApplicationController
  def search
    @term = params[:term]&.strip
    @entries = matching_entries.uniq.first(10) if @term
  end

  private

  def term_regex
    @term_regex ||= "#{@term}|#{@term.pluralize}|#{@term.singularize}"
  end

  def matching_entries
    entry_scope.where("entries.title ~* '#{term_regex}'") +
      entry_scope.where("tags.name ~* '#{term_regex}'") +
      entry_scope.where("ingredient_entries.ingredient_name ~* '#{term_regex}'")
  end

  def entry_scope
    @entry_scope ||= Entry.distinct
      .published
      .left_outer_joins(:tags)
      .left_outer_joins(recipe: {ingredient_sets: :ingredient_entries})
      .order(published_at: :desc)
  end
end

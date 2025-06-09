class TagsController < ApplicationController
  caches_page :show

  def show
    @tag_name = params[:tag_name]

    unless @tag_name == @tag_name.downcase
      redirect_to tag_path(@tag_name.downcase)
    end

    @entries = tagged_entries.where(tags: {name: @tag_name})
      .or(tagged_entries.where(tags: {name: @tag_name.pluralize}))
      .or(tagged_entries.where(tags: {name: @tag_name.singularize}))
      .order(created_at: :desc)
  end

  private

  def tagged_entries
    @tagged_entries ||= Entry.joins(:tags)
  end
end

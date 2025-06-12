# frozen_string_literal: true
class RssFeedsController < ApplicationController
  def index
    all_entries = Recipe.published_with_image + BlogPost.published + DigestedRead.published
    @entries = all_entries.sort_by(&:display_date).reverse

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
end

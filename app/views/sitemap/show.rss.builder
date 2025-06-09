xml.instruct! :xml, version: "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", "xmlns:xhtml" => "http://www.w3.org/1999/xhtml" do
  host = Rails.application.default_url_options[:host]

  xml.url do
    xml.loc host
    xml.lastmod Entry.date_of_latest_update.strftime("%Y-%m-%d")
  end

  xml.url do
    xml.loc host + "/about"
    xml.lastmod "2022-01-10"
  end

  xml.url do
    xml.loc host + "/recipe-index"
    xml.lastmod Entry.date_of_latest_creation.strftime("%Y-%m-%d")
  end

  xml.url do
    xml.loc host + "/blog-post-index"
    xml.lastmod Entry.date_of_latest_creation.strftime("%Y-%m-%d")
  end

  @entries.each do |entry|
    xml.url do
      xml.loc host + entry.permalink
      xml.lastmod entry.updated_at.strftime("%Y-%m-%d")
    end
  end

  @collections.each do |collection|
    xml.url do
      xml.loc host + "/collection#{collection.permalink}"
      xml.lastmod collection.updated_at.strftime("%Y-%m-%d")
    end
  end

  # @tags.each do |tag|
  #   xml.url do
  #     xml.loc host + "/tags/#{tag.name}"
  #   end
  # end

  @ingredients.each do |ingredient|
    xml.url do
      xml.loc host + "/ingredient/#{ingredient.name.downcase}"
      xml.lastmod ingredient.updated_at.strftime("%Y-%M-%D")
    end
  end

end

module Publishable
  def published?
    !published_at.nil?
  end

  def publish!
    self.update!(published_at: DateTime.now)
  end

  def unpublish!
    self.update!(published_at: nil)
  end

  def description_for_rss_feed
    case self.class.to_s
    when "Recipe"
      introduction_paragraphs.first
    when "BlogPost"
      content_sections.first
    when "DigestedRead"
      content_sections.first
    end
  end
end

class MarkdownConverter
  require "redcarpet"

  def self.convert(markdown)
    converter = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    converter.render(markdown)
  end
end

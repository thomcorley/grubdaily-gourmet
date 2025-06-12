module DigestedReadsHelper
  def formatted_section(section)
    converted_markdown = MarkdownConverter.convert(section)
    simple_format(converted_markdown)
  end
end

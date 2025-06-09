module Excerptable
  extend ActiveSupport::Concern

  def excerpt(truncate_at = 140)
    MarkdownConverter.convert("#{introduction.first(truncate_at)} ...")
  end
end

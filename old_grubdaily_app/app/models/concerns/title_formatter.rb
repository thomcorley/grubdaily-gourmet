module TitleFormatter
  extend ActiveSupport::Concern

  # The title stripped of all commas, dots, apostrophes and accents
  def url_friendly_title
    remove_punctuation_from(title_with_no_accents).split.reject{ |i| %w(and with of au a la).include? i.downcase }.join(" ")
  end

  def remove_punctuation_from(string)
    string.gsub(/[\,\.':]/, "")
  end

  def title_with_no_accents
    ActiveSupport::Inflector.transliterate(title)
  end

  def permalink
    "/#{url_friendly_title.downcase.split.join("-")}"
  end
end

class Collection < ApplicationRecord
  include TitleFormatter

  has_many :collection_entries
  has_many :entries, through: :collection_entries

  scope :published, -> { where("published_at <= ?", Date.today)}

  def introduction_paragraphs
    introduction.split("\r\n\r\n").compact
  end
end

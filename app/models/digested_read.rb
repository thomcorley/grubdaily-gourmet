class DigestedRead < ApplicationRecord
  include TitleFormatter
  include Image
  include Publishable
  include Taggable

  validates_presence_of :title, :summary, :content

  has_one_attached :image
  has_one_attached :book_cover

  has_many :digested_read_taggings
  has_many :tags, through: :digested_read_taggings

  scope :published, -> { where.not(published_at: nil) }

  def display_date
    published_at || created_at
  end

  def permalink
    "/digested/#{url_friendly_title.downcase.split.join("-")}"
  end

  def content_sections
    content.split("---")
  end

  def published?
    !published_at.nil?
  end

  def author_info_sections
    author_info.split("\n")
  end
end

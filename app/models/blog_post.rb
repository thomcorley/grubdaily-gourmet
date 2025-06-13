class BlogPost < ApplicationRecord
  include Entryable
  include TitleFormatter
  include Publishable
  include Excerptable
  include Image

  has_many_attached :attached_images

  validates :title, presence: true, uniqueness: true
  validates :title, length: { maximum: 50 }
  validate :content_section_delimiter

  delegate :tags, :tag_names, :tags=, :content, :summary, to: :entry, allow_nil: true

  scope :published, -> { where.not(published_at: nil) }

  scope :for_homepage_selection, -> {
    published.order(published_at: :desc).limit(9)
  }

  scope :published_with_image, -> { published.where(has_image: true) }

  before_save :set_has_image

  def self.get(permalink)
    BlogPost.select{ |blog_post| blog_post.permalink == "/#{permalink}"}.first
  end

  def has_image?
    image.present?
  end

  def image
    attached_images.first
  end

  def second_image
    attached_images.second
  end

  def third_image
    attached_images.third
  end

  def content_sections
    entry.content.split("---")
  end

  def introduction
    content_sections.first
  end

  def display_date
    published_at || created_at
  end

  def permalink
    "/posts/#{url_friendly_title.downcase.split.join("-")}"
  end

  # TODO: make this a common method
  def rating_value
    [4, 4.5, 5].sample
  end

  # TODO: make this a common method
  def rating_count
    rand(20..98)
  end

  def word_count
    content.split.size
  end

  def url
    "https://www.grubdaily.com#{permalink}"
  end

  def process_image_variants
    return unless image_attached?

    attached_images.each do |image|

      IMAGE_VARIANTS.each do |size|
        resolved_image(image, size)
      end
    end
  end

  def keywords
    (["blog post"] + tags.map(&:name)).join(',')
  end

  def image_attached?
    attached_images.attached?
  end

  private

  def markdown_converted_content
    MarkdownConverter.convert(content)
  end

  def content_section_delimiter
    unless content =~ /---/
      errors.add(:content, "must include at least one `---` to delimit sections")
    end
  end

  def set_has_image
    self.has_image = image_attached?
  end
end

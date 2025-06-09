class Entry < ApplicationRecord
  include TitleFormatter
  include Publishable
  include Taggable

  has_many :entry_taggings
  has_many :tags, through: :entry_taggings
  belongs_to :recipe, class_name: 'Recipe', foreign_key: :entryable_id, optional: true
  belongs_to :blog_post, class_name: 'BlogPost', foreign_key: :entryable_id, optional: true

  has_many :collection_entries
  has_many :collections, through: :collection_entries

  delegated_type :entryable, types: %w[ Recipe BlogPost StapleRecipe ]
  delegate :image, :attached_images, :resolved_image, :has_image?, :permalink, :related_entries, to: :entryable

  scope :all_recipes, -> { where(entryable_type: ["Recipe", "StapleRecipe"])}
  scope :published, -> { where.not(published_at: nil) }
  scope :published_with_image, -> { published.where(has_image: true).order(title: :asc) }
  scope :marked_for_promotion, -> { where.not(marked_for_promotion_at: nil) }
  scope :updated_recently, -> { order(updated_at: :desc) }
  scope :created_recently, -> { order(created_at: :desc) }

  before_save :set_has_image

  def self.date_of_latest_update
    updated_recently.first.updated_at
  end

  def self.date_of_latest_creation
    created_recently.first.created_at
  end

  private

  def set_has_image
    self.has_image = entryable.image_attached?
  end
end

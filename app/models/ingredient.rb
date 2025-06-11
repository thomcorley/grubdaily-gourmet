class Ingredient < ApplicationRecord
  include Image

  has_many :ingredient_entry_ingredient_sources
  has_many :ingredient_entries, through: :ingredient_entry_ingredient_sources
  has_one_attached :image

  enum :animal_status, [:vegan, :vegetarian, :pescatarian, :omnivorous], prefix: true

  validates :name, presence: true
  validates :animal_status, presence: true

  before_save :set_nutrition_from_api

  scope :published, -> { where(publishable: true) }
  scope :with_content, -> { where.not(content: nil).where.not(content: '') }

  def self.find_by_synonym(name_or_synonym)
    name_or_synonym.downcase!

    where(name: name_or_synonym.singularize).or(
      where(name: name_or_synonym.pluralize).or(
        where("synonyms LIKE '%#{name_or_synonym.singularize}%'").or(
          where("synonyms LIKE '%#{name_or_synonym.pluralize}%'")
        )
      )
    )&.first
  end

  def publish!
    update!(publishable: true)
  end

  def unpublish!
    update!(publishable: false)
  end

  def title
    name
  end

  def set_nutrition_from_api
    self.nutrition = Nutrition::Api.get_json(self.name)
  end

  def keywords
    [
      'ingredient',
      name.downcase,
      'culinary history',
      'nutritional information',
      'nutrition'
    ].join(',')
  end
end

class IngredientSet < ApplicationRecord
  has_many :ingredient_entries, dependent: :destroy
  belongs_to :recipe
  validate :length_of_title_if_present
  validates_associated :ingredient_entries
  accepts_nested_attributes_for :ingredient_entries

  def title_for_display
    return "Ingredients" if title.blank?
    return "Ingredients" if title == "INSERT_TITLE"
    title.downcase
  end

  def ordered_ingredient_entries
    ingredient_entries.order(position: :asc)
  end

  private
  # Extra model validations
  def length_of_title_if_present
    errors.add(:title, "cannot be longer that 30 characters") if title && title.length > 30
  end
end

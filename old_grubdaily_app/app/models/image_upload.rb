class ImageUpload < ApplicationRecord
  include Image
  include TitleFormatter

  has_one_attached :image

  validates :title, uniqueness: true, presence: true

  def as_yaml
    as_json(
      methods: :images
    ).to_yaml
  end

  private

  def images
    ImageSet.new(self).images
  end
end

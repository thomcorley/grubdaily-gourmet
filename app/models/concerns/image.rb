module Image
  extend ActiveSupport::Concern

  TINY_SQUARE = [
    [40, 40],
    [40, 40],
    [40, 40],
  ]

  SMALL_SQUARE = [
    [80, 80],
    [100, 100],
    [150, 150],
  ]

  MEDIUM_SQUARE = [
    [180, 180],
    [240, 240],
    [280, 280],
  ]

  LARGE_SQUARE = [
    [300, 300],
    [380, 380],
    [460, 460],
  ]


  SQUARE_VARIANTS = TINY_SQUARE + SMALL_SQUARE + MEDIUM_SQUARE + LARGE_SQUARE

  MAIN = [
    [510, 510],
    [624, 416],
    [960, 640],
  ]

  CAROUSEL = [
    [360, 240],
    [420, 280],
    [624, 416],
  ]

  INGREDIENT = [
    [405, 540],
    [405, 540],
    [300, 400],
  ]

  LANDSCAPE_VARIANTS = MAIN + CAROUSEL + INGREDIENT

  IMAGE_VARIANTS = SQUARE_VARIANTS + LANDSCAPE_VARIANTS

  def resolved_image(image_object, size)
    unless IMAGE_VARIANTS.include?(size)
      raise "Size #{size} must be included in IMAGE_VARIANTS list"
    end

    # Handle nil, ActiveStorage::Attachment objects, and associations
    is_attached = if image_object.nil?
      false
    elsif image_object.is_a?(ActiveStorage::Attachment)
      image_object.present?
    else
      image_object.attached?
    end

    if is_attached
      is_square = size[0] == size[1]
      if is_square
        image_object.variant(
          resize_to_fill: size,
          gravity: "north",
          format: :webp
        ).processed
      else
        image_object.variant(resize_to_limit: [size[0], size[1]], format: :webp).processed
      end
    else
      "/images/placeholder.jpg"
    end
  end
end

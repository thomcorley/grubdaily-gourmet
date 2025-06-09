class ImageSet
  include Rails.application.routes.url_helpers

  attr_reader :entry

  def initialize(entry)
    @entry = entry
  end

  def images
    main_version = Image::MAIN
    thumbnail_version = Image::MEDIUM_SQUARE

    {
      main: {
        small: cdn_image_url(entry.resolved_image(entry.image, main_version[0])),
        medium: cdn_image_url(entry.resolved_image(entry.image, main_version[1])),
        large: cdn_image_url(entry.resolved_image(entry.image, main_version[2]))
      },
      thumbnails: {
        small: cdn_image_url(entry.resolved_image(entry.image, thumbnail_version[0])),
        medium: cdn_image_url(entry.resolved_image(entry.image, thumbnail_version[1])),
        large: cdn_image_url(entry.resolved_image(entry.image, thumbnail_version[2]))
      }
    }
  end

end

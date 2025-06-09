module Image::Optimisation
  # Note! This does not work in production unless the server has ImageMagick v7 installed.
  def optimise_image(image)
    return unless image.attached?

    filename = image.filename.sanitized
    filepath = "#{Rails.root.to_s}/tmp/images/#{filename}"

    # Run imageMagick command directly on command line
    `magick #{image.url} -strip -quality 35 -colorspace sRGB -define webp:image-hint=photo -define webp:emulate-jpeg-size=true -define webp:method=6 -define webp:low-memory=true -define webp:filter-strength=30 -define webp:filter-type=1 -define webp:pass=5 -define webp:target-size=30000 -define webp:thread-level=1 -define webp:sns-strength=100 -define webp:segment=4 -verbose #{filepath}`

    # Smaller command that perhaps produces better results:
    # magick vindaloo-key-ingredients.jpeg -quality 90 -colorspace sRGB -define webp:image-hint=photo -define webp:alpha-quality=50 -resize 780x780 vindaloo-key-ingredients.webp

    sleep(10)
    image.purge

    image.attach(
      io: File.open(filepath),
      filename: filename
    )
  end
end

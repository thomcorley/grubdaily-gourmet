class ImageProcessingJob < ApplicationJob
  queue_as :default

  def perform(record)
    record.process_image_variants
  end
end 
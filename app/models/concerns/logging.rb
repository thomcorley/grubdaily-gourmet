module Logging
  def logger
    @logger ||= Rails.logger
  end

  def log_error(message)
    logger.error("#{log_prefix} #{message}")
  end

  def log_info(message)
    logger.info("#{log_prefix} #{message}")
  end

  def log_prefix
    "[#{self.class}]"
  end
end

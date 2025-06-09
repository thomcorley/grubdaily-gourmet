class RecommendedEntries
  def self.find_for(entry:, size:)
    return [] unless entry

    new(entry: entry, size: size).get_recommended_entries
  end

  attr_reader :entry, :size

  def initialize(entry:, size:)
    @entry = entry
    @size = size
  end

  def get_recommended_entries
    tag_names = entry.tags.pluck(:name)

    if entries_by_tag.size < 4
      Rails.logger.info("INFO! (sampled)")
      (entries_by_tag + sample_of_entries).first(4)
    else
      Rails.logger.info("INFO! (tagged)")
      entries_by_tag
    end
  end

  private

  def entries_by_tag
    tag_names = entry.tags.pluck(:name)

    entries = Entry.distinct
                   .published
                   .joins(:tags)
                   .where(entryable_type: entry.entryable_type)
                   .where(tags: {name: tag_names})
                   .where.not(id: entry.id)

    @entries_by_tag ||= entries.offset(rand(entries.count)).limit(size)
  end

  def sample_of_entries
    entries = Entry.distinct
      .published
      .where(entryable_type: entry.entryable_type)
      .where.not(id: entry.id)

    entries.offset(rand(entries.count)).limit(size)
  end
end

module Entryable
  extend ActiveSupport::Concern

  included do
    has_one :entry, as: :entryable, touch: true

    scope :updated_recently, -> { order(updated_at: :desc) }
    scope :created_recently, -> { order(created_at: :desc) }
  end

  def humanised_type
    self.class.to_s.underscore.humanize.titleize
  end
end

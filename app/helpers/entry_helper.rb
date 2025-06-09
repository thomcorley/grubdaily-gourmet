module EntryHelper
  def display_entry_class(entries, index, truncate = true)
    return '' unless truncate

    is_last_entry = (index + 1 == entries.size)
    is_multiple_of_three = (entries.size % 3 == 0)

    'is-hidden-tablet-only' if is_last_entry && !is_multiple_of_three
  end
end

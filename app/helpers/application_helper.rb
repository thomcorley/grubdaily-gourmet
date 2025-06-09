module ApplicationHelper
  def title(text)
    content_for :title, text
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def admin_session?
    Rails.env.development? ||
      Rails.env.test? ||
        current_user&.id == 1
  end

  def application_host
    Rails.application.default_url_options[:host]
  end

  def datetime_select_options(date = nil)
    {
      selected: {
        year: date&.year,
        month: date&.month,
        day: date&.day,
        hour: date&.hour
      },
      discard_minute: true,
      prompt: true,
      end_year: 2010,
      start_year: Date.today.year,
      class: "select",
      datetime_separator: "",
      time_separator: "",
      date_separator: ""
    }
  end

  def recaptcha_site_key
    if Rails.env.development?
      Rails.application.credentials.dig(:recaptcha, :site_key_development)
    else
      Rails.application.credentials.dig(:recaptcha, :site_key_production)
    end
  end

  def time_ago(timestamp)
    return "" unless timestamp
    "#{time_ago_in_words(timestamp)} ago"
  end

  def edit_link
    if @recipe&.persisted?
      edit_recipe_path(@recipe)
    elsif @blog_post&.persisted?
      edit_blog_post_path(@blog_post)
    elsif @ingredient&.persisted?
      edit_ingredient_path(@ingredient)
    elsif @collection&.persisted?
      edit_collection_path(@collection)
    elsif @image_upload&.persisted?
      edit_image_upload_path(@image_upload)
    else
      nil
    end
  end
end

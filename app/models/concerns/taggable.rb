module Taggable
  extend ActiveSupport::Concern

  def tags=(tag_names)
    tag_names = tag_names.split(', ') if tag_names.is_a?(String)
    tags.destroy_all

    tag_names.each do |tag_name|
      create_tagging(tag_name)
    end
  end

  def create_tagging(name)
    tag = Tag.find_or_create_by(name: name)

    id_param = case self.class.to_s
    when "Recipe"
      {recipe_id: self.id}
    when "BlogPost"
      {blog_post_id: self.id}
    when "DigestedRead"
      {digested_read_id: self.id}
    when "Entry"
      {entry_id: self.id}
    else
      {}
    end

    tagging_class.send(:find_or_create_by, {tag_id: tag.id}.merge(id_param))
  end

  def remove_tagging(name)
    tag = Tag.find_by(name: name)
    return unless tag

    tagging_class.find_by(tag_id: tag.id)&.destroy
  end

  def tag_names
    tags.pluck(:name).join(', ')
  end

  private

  def tagging_class
    "#{self.class}Tagging".constantize
  end
end

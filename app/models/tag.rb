class Tag < ApplicationRecord
  has_many :entry_taggings
  has_many :entries, through: :entry_taggings

  has_many :recipe_taggings
  has_many :recipes, through: :recipe_taggings

  has_many :blog_post_taggings
  has_many :blog_posts, through: :blog_post_taggings

  has_many :digested_read_taggings
  has_many :digested_reads, through: :digested_read_taggings
end

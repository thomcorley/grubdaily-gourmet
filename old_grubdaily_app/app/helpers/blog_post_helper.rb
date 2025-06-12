module BlogPostHelper
  def blog_post_json_schema
    JSON.generate({
      "@context": "http://schema.org",
      "@type": "BlogPosting",
      name: @blog_post.title,
      headline: @blog_post.title,
      author: {
        "@type": "Person",
        name: "Tom Corley",
        givenName: "Tom",
        familyName: "Corley",
        jobTitle: "Chef"
      },
      image: blog_post_image,
      datePublished: @blog_post.published_at,
      abstract: @blog_post.summary,
      articleBody: @blog_post.content,
      wordCount: @blog_post.word_count,
      publisher: {
        "@type": "Organization",
        name: "grubdaily",
        logo: {
          "@type": "ImageObject",
          url: "http://www.grubdaily.com/favicon_large.jpg"
        }
      }
    }).html_safe
  end

  def formatted_section(section)
    converted_markdown = MarkdownConverter.convert(section)
    simple_format(converted_markdown)
  end

  def blog_post_image
    return unless @blog_post.attached_images.attached?
    rails_storage_proxy_url(@blog_post.attached_images.first.variant(resize_to_limit: [300, 300]))
  end
end

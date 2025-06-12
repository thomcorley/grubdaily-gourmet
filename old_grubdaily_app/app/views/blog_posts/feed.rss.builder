xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0", "xmlns:atom": "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Blog Post List"
    xml.description "All grubdaily Blog Posts"
    xml.link "https://www.grubdaily.com"
    @blog_posts.each do |blog_post|
      xml.item do
        xml.title blog_post.title
        xml.link "https://www.grubdaily.com#{blog_post.permalink}"
        xml.enclosure(
          url: rails_storage_proxy_url(blog_post.attached_images.first.variant(resize_to_limit: [500, 500])),
          length: blog_post.attached_images.first.byte_size,
          type: "image/jpeg",
        )
        xml.description blog_post.description_for_rss_feed
        xml.category blog_post.class.to_s
        xml.pubDate blog_post.created_at.rfc2822
      end
    end
  end
end

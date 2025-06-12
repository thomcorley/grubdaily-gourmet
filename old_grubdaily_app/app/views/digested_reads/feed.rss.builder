xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0", "xmlns:atom": "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Digested Read List"
    xml.description "All grubdaily Digested Reads"
    xml.link "https://www.grubdaily.com"
    @digested_reads.each do |digested_read|
      xml.item do
        xml.title digested_read.title
        xml.link "https://www.grubdaily.com#{digested_read.permalink}"
        xml.enclosure(
          url: rails_storage_proxy_url(digested_read.image.variant(resize_to_limit: [500, 500])),
          length: digested_read.image.byte_size,
          type: "image/jpeg",
        )
        xml.description digested_read.description_for_rss_feed
        xml.category digested_read.class.to_s
        xml.pubDate digested_read.display_date.rfc2822
      end
    end
  end
end

xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0", "xmlns:atom": "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Image List"
    xml.description "All grubdaily images"
    xml.link "https://www.grubdaily.com"
  end
end

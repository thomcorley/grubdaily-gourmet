FactoryBot.define do
  factory :blog_post, class: BlogPost do
    title { "My first blog post" }
    summary { "A very special post about something very dear to my heart" }
    content {
      "Lorem Ipsum is simply dummy text of the printing and typesetting " \
      "industry./n/n --- Lorem Ipsum has been the industry"
    }
    images { "my-first-blog-post\nsecond-picture" }
    tags { "these, are, test, tags" }
    published_at { Time.now }

    after(:build) do |blog_post|
      blog_post.attached_images.attach([
        {
          io: File.open(Rails.root.join("app", "assets", "images", "apple-tarte-tatin.jpg")),
          filename: "apple-tarte-tatin.jpg",
          content_type: "image/jpeg",
        },
        {
          io: File.open(Rails.root.join("app", "assets", "images", "arbroath-smoky.jpg")),
          filename: "arbroath-smoky.jpg",
          content_type: "image/jpeg",
        },
        {
          io: File.open(Rails.root.join("app", "assets", "images", "asian-noodle-soup.jpg")),
          filename: "asian-noodle-soup.jpg",
          content_type: "image/jpeg",
        },
      ])
    end
  end
end

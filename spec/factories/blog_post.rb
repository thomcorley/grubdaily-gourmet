FactoryBot.define do
  factory :blog_post_without_entry, class: BlogPost do
    title { "My first blog post" }
    images { "my-first-blog-post\nsecond-picture" }
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

  factory :blog_post, class: BlogPost do
    title { "My first blog post" }
    images { "my-first-blog-post\nsecond-picture" }
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

      # Create the associated entry
      entry = build(:entry,
        title: blog_post.title,
        summary: "A very special post about something very dear to my heart",
        content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry./n/n --- Lorem Ipsum has been the industry",
        published_at: blog_post.published_at
      )
      entry.entryable = blog_post
      blog_post.entry = entry
    end

    after(:create) do |blog_post, _evaluator|
      blog_post.entry.save! if blog_post.entry
      
      # Set up default tags
      blog_post.tags = ["blog", "personal", "writing"]
    end
  end
end

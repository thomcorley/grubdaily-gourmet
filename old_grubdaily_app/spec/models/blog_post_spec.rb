require "rails_helper"

RSpec.describe BlogPost do
  let(:images) { "image-title1\r\nimage-title2\r\nimage-title3" }
  let(:blog_post) { FactoryBot.create(:blog_post, images: images) }

  describe "#first_image" do
    it "returns the first image from the `images` field" do
      expect(blog_post.image).to be_a(ActiveStorage::Attachment)
    end
  end

  describe "#second_image" do
    it "returns the second image from the `images` field" do
      expect(blog_post.second_image).to be_a(ActiveStorage::Attachment)
    end
  end

  describe "#third_image" do
    it "returns the third image from the `images` field" do
      expect(blog_post.third_image).to be_a(ActiveStorage::Attachment)
    end
  end

  describe "content_sections" do
    let(:content) { "Lorem Ipsum\r\n---\r\nis simply dummy text\r\n---\r\nof the printing\r\n---\r\nindustry" }
    before { blog_post.content = content }

    it "returns the sections delimited by '---'" do
      sections = ["Lorem Ipsum\r\n", "\r\nis simply dummy text\r\n", "\r\nof the printing\r\n", "\r\nindustry" ]
      expect(blog_post.content_sections).to eq(sections)
    end
  end

  describe "#publish!" do
    let(:now) { "Wed, 28 Jul 2021 07:23:46.867401000 UTC +00:00" }

    before do
      allow(DateTime).to receive(:now).and_return(now)
      blog_post.publish!
    end

    it "sets the `published_at` attribute" do
      expect(blog_post.published_at).to eq(now)
    end
  end

  describe "#unpublish!" do
    let(:now) { "Wed, 28 Jul 2021 07:23:46.867401000 UTC +00:00" }

    before do
      allow(DateTime).to receive(:now).and_return(now)
      blog_post.unpublish!
    end

    it "clears the `published_at` attribute" do
      expect(blog_post.published_at).to eq(nil)
    end
  end
end

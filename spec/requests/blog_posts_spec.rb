# frozen_string_literal: true
require "rails_helper"

RSpec.describe "BlogPosts" do
  let(:blog_post) { create(:blog_post) }

  context "GET blog_posts/<ID>" do
    it "renders the BlogPost show page" do
      get blog_post_path(blog_post)
      expect(response).to be_successful
    end

    it "renders using the parameterised path" do
      get blog_post.permalink
      expect(response).to be_successful
    end
  end

  context "with no images attached" do
    let(:placeholder_image) { /src="\/images\/placeholder.*\.jpg"/ }
    before { blog_post.attached_images.each(&:purge) }

    it "renders with a placeholder image" do
      get blog_post_path(blog_post)
      expect(response).to be_successful
      expect(response.body).to match(placeholder_image)
    end
  end
end

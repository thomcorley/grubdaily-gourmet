require "rails_helper"

RSpec.describe HomeController do
  describe "#latest_entry" do
    let!(:recipe) { create(:recipe) }
    let!(:blog_post) { create(:blog_post, published_at: Date.yesterday) }

    it "loads successfully" do
      get :latest_entry

      expect(response).to redirect_to(recipe.permalink)
    end
  end
end

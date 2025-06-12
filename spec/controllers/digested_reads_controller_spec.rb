require "rails_helper"

RSpec.describe DigestedReadsController do

  # This should return the minimal set of attributes required to create a valid
  # DigestedRead. As you add validations to DigestedRead, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      title: "Test title",
      summary: "Lorem Ipsum is",
      content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
      tags: "these, are, test, tags",
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      summary: "Lorem Ipsum is",
      content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
      tags: "these, are, test, tags",
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DigestedReadsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new DigestedRead" do
        expect {
          post :create, params: {digested_read: valid_attributes}
        }.to change(DigestedRead, :count).by(1)
      end

      it "redirects to the created digested_read" do
        post :create, params: {digested_read: valid_attributes}
        expect(response).to redirect_to(DigestedRead.last)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title: "Test title 2",
          summary: "Lorem Ipsum is",
          content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
          tags: "these, are, test, tags",
        }
      }

      it "updates the requested digested_read" do
        digested_read = DigestedRead.create! valid_attributes
        put :update, params: {id: digested_read.to_param, digested_read: new_attributes}
        digested_read.reload
        expect(digested_read.title).to eq("Test title 2")
      end

      it "redirects to the digested_read" do
        digested_read = DigestedRead.create! valid_attributes
        put :update, params: {id: digested_read.to_param, digested_read: valid_attributes}
        expect(response).to redirect_to(digested_read)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested digested_read" do
      digested_read = DigestedRead.create! valid_attributes
      expect {
        delete :destroy, params: {id: digested_read.to_param}
      }.to change(DigestedRead, :count).by(-1)
    end

    it "redirects to the digested_reads list" do
      digested_read = DigestedRead.create! valid_attributes
      delete :destroy, params: {id: digested_read.to_param}
      expect(response).to redirect_to(root_url)
    end
  end
end

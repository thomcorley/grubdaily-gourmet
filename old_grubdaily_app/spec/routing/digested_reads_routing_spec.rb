require "rails_helper"

RSpec.describe DigestedReadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/digested_reads").to route_to("digested_reads#index")
    end

    it "routes to #new" do
      expect(:get => "/digested_reads/new").to route_to("digested_reads#new")
    end

    it "routes to #show" do
      expect(:get => "/digested_reads/1").to route_to("digested_reads#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/digested_reads/1/edit").to route_to("digested_reads#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/digested_reads").to route_to("digested_reads#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/digested_reads/1").to route_to("digested_reads#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/digested_reads/1").to route_to("digested_reads#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/digested_reads/1").to route_to("digested_reads#destroy", :id => "1")
    end
  end
end

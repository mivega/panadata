require "spec_helper"

describe CorporationsController do
  describe "routing" do

    it "routes to #index" do
      get("/corporations").should route_to("corporations#index")
    end

    it "routes to #new" do
      get("/corporations/new").should route_to("corporations#new")
    end

    it "routes to #show" do
      get("/corporations/1").should route_to("corporations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/corporations/1/edit").should route_to("corporations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/corporations").should route_to("corporations#create")
    end

    it "routes to #update" do
      put("/corporations/1").should route_to("corporations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/corporations/1").should route_to("corporations#destroy", :id => "1")
    end

  end
end

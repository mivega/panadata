require "spec_helper"

describe LicitationsController do
  describe "routing" do

    it "routes to #index" do
      get("/licitations").should route_to("licitations#index")
    end

    it "routes to #new" do
      get("/licitations/new").should route_to("licitations#new")
    end

    it "routes to #show" do
      get("/licitations/1").should route_to("licitations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/licitations/1/edit").should route_to("licitations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/licitations").should route_to("licitations#create")
    end

    it "routes to #update" do
      put("/licitations/1").should route_to("licitations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/licitations/1").should route_to("licitations#destroy", :id => "1")
    end

  end
end

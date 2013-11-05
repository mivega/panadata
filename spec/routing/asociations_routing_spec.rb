require "spec_helper"

describe AsociationsController do
  describe "routing" do

    it "routes to #index" do
      get("/asociations").should route_to("asociations#index")
    end

    it "routes to #new" do
      get("/asociations/new").should route_to("asociations#new")
    end

    it "routes to #show" do
      get("/asociations/1").should route_to("asociations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/asociations/1/edit").should route_to("asociations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/asociations").should route_to("asociations#create")
    end

    it "routes to #update" do
      put("/asociations/1").should route_to("asociations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/asociations/1").should route_to("asociations#destroy", :id => "1")
    end

  end
end

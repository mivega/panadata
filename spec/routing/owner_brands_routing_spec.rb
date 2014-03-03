require "spec_helper"

describe OwnerBrandsController do
  describe "routing" do

    it "routes to #index" do
      get("/owner_brands").should route_to("owner_brands#index")
    end

    it "routes to #new" do
      get("/owner_brands/new").should route_to("owner_brands#new")
    end

    it "routes to #show" do
      get("/owner_brands/1").should route_to("owner_brands#show", :id => "1")
    end

    it "routes to #edit" do
      get("/owner_brands/1/edit").should route_to("owner_brands#edit", :id => "1")
    end

    it "routes to #create" do
      post("/owner_brands").should route_to("owner_brands#create")
    end

    it "routes to #update" do
      put("/owner_brands/1").should route_to("owner_brands#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/owner_brands/1").should route_to("owner_brands#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe PersonasController do
  describe "routing" do

    it "routes to #index" do
      get("/personas").should route_to("personas#index")
    end

    it "routes to #new" do
      get("/personas/new").should route_to("personas#new")
    end

    it "routes to #show" do
      get("/personas/1").should route_to("personas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/personas/1/edit").should route_to("personas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/personas").should route_to("personas#create")
    end

    it "routes to #update" do
      put("/personas/1").should route_to("personas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/personas/1").should route_to("personas#destroy", :id => "1")
    end

  end
end

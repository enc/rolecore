require "spec_helper"

describe RelationPropertiesController do
  describe "routing" do

    it "routes to #index" do
      get("/relation_properties").should route_to("relation_properties#index")
    end

    it "routes to #new" do
      get("/relation_properties/new").should route_to("relation_properties#new")
    end

    it "routes to #show" do
      get("/relation_properties/1").should route_to("relation_properties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/relation_properties/1/edit").should route_to("relation_properties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/relation_properties").should route_to("relation_properties#create")
    end

    it "routes to #update" do
      put("/relation_properties/1").should route_to("relation_properties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/relation_properties/1").should route_to("relation_properties#destroy", :id => "1")
    end

  end
end

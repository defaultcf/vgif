require "rails_helper"

RSpec.describe GifsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/gifs").to route_to("gifs#index")
    end

    it "routes to #new" do
      expect(get: "/gifs/new").to route_to("gifs#new")
    end

    it "routes to #show" do
      expect(get: "/gifs/1").to route_to("gifs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/gifs/1/edit").to route_to("gifs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/gifs").to route_to("gifs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/gifs/1").to route_to("gifs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/gifs/1").to route_to("gifs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/gifs/1").to route_to("gifs#destroy", id: "1")
    end
  end
end

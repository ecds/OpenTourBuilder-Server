require "rails_helper"

RSpec.describe ThemesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/themes").to route_to("themes#index")
    end


    it "routes to #show" do
      expect(:get => "/themes/1").to route_to("themes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/themes").to route_to("themes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/themes/1").to route_to("themes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/themes/1").to route_to("themes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/themes/1").to route_to("themes#destroy", :id => "1")
    end

  end
end

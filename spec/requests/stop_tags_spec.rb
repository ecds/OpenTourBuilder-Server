require 'rails_helper'

RSpec.describe "StopTags", type: :request do
  describe "GET /stop_tags" do
    it "works! (now write some real specs)" do
      get stop_tags_path
      expect(response).to have_http_status(200)
    end
  end
end

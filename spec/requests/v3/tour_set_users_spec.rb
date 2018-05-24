require 'rails_helper'

RSpec.describe 'V3::TourSetUsers', type: :request do
  describe 'GET /tour_set_users' do
    before { get "/#{Apartment::Tenant.current}/tour-set-users" }
    it 'works! (now write some real specs)' do
      expect(response).to have_http_status(401)
    end
  end
end

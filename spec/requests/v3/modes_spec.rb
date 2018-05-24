# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Modes', type: :request do
  describe 'GET /modes' do
    before { get "/#{Apartment::Tenant.current}/modes" }
    it 'works! (now write some real specs)' do
      expect(response).to have_http_status(200)
    end
  end
end

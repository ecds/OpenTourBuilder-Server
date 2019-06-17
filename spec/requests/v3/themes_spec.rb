# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Themes', type: :request do
  describe 'GET /themes' do
    before { get "/#{Apartment::Tenant.current}/themes" }
    it 'works! (now write some real specs)' do
      get themes_path
      expect(response).to have_http_status(200)
    end
  end
end

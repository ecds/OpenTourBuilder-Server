# frozen_string_literal: true

# app/requests/stops_spec.rb
require 'rails_helper'

RSpec.describe 'V3::Stops API' do
  # Initialize the test data
  let!(:theme) { create(:theme) }
  let!(:tours) { create(:tour_with_stops, stops_count: 20, theme: theme) }
  let(:tour_stop_id) { tours.first.tour_stops.first.id }

  # Test suite for GET /stops
  describe 'GET /tour-stops' do
    before { get "/#{Apartment::Tenant.current}/tour-stops" }

    context 'when stops exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tour stops' do
        expect(json.size).to eq(20)
      end
    end

    context 'previous and next are correct' do
      it 'previous is 3' do
        expect(json[3]['attributes']['previous']['id']).to eq(json[3]['id'].to_i - 1)
      end

      it 'next is 5' do
        expect(json[3]['attributes']['next']['id']).to eq(json[3]['id'].to_i + 1)
      end
    end
  end
end

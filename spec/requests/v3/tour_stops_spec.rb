# frozen_string_literal: true

# app/requests/stops_spec.rb
require 'rails_helper'

RSpec.describe 'V3::Stops API' do
  # Initialize the test data

  # Test suite for GET /stops
  describe 'GET /tour-stops' do
    before { Apartment::Tenant.switch! TourSet.second.subdir }
    # before { Tour.first.stops << Stop.last(5) }
    before { get "/#{Apartment::Tenant.current}/tour-stops" }

    context 'when stops exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tour stops' do
        expect(json.size).to eq(TourStop.count)
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

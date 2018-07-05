# frozen_string_literal: true

# app/requests/stops_spec.rb
require 'rails_helper'

RSpec.describe 'V3::Stops API' do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:login) { create(:login, user: user) }
  let!(:theme) { create(:theme) }
  let!(:tour) { create(:tour_with_stops, stops_count: 20, theme: theme, published: true) }
  let!(:tour_id) { tour.id }
  let!(:stops) { tour.stops }
  let(:id) { stops.first.id }

  # Test suite for GET /stops
  describe 'GET /stops' do
    before { get "/#{Apartment::Tenant.current}/stops" }

    context 'when stops exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tour stops' do
        expect(json.size).to eq(20)
      end
    end
  end

  # Test suite for GET /stops/:id
  describe 'GET /stops/:id' do
    before { get "/#{Apartment::Tenant.current}/stops/#{id}" }

    context 'when tour stop exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the stop' do
        expect(json['id']).to eq(id.to_s)
      end

      it 'has a metadescription based on description truncated and sanitized' do
        expect(attributes['metadescription']).not_to include('<p>')
      end
    end

    context 'when tour stop does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stop/)
      end
    end
  end

  # Test suite for POST /stops
  describe 'POST /stops' do
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:stop, title: 'Players Ball'))
    end

    context 'when request attributes are valid' do
      before { post "/#{Apartment::Tenant.current}/stops", params: valid_attributes, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

      it 'returns status code 201' do
        expect(tour.stops.length).to eq(20)
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/#{Apartment::Tenant.current}/stops", params: {}, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      # it 'returns a failure message' do
      #   expect(response.body).to match(/\{\"title\"\:\[\"can\'t be blank\"\]\}/)
      # end
    end
  end

  # Test suite for PUT /stops/:id
  describe 'PUT /stops/:id' do
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:stop, title: '3 Stacks'))
    end

    before { put "/#{Apartment::Tenant.current}/stops/#{id}", params: valid_attributes, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

    context 'when stop exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the stop' do
        updated_stop = Stop.find(id)
        expect(updated_stop.title).to match(/3 Stacks/)
      end
    end

    context 'when the stop does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stop/)
      end
    end
  end

  # Test suite for DELETE /stops/:id
  describe 'DELETE /stops/:id' do
    before { delete "/#{Apartment::Tenant.current}/stops/#{id}", headers: { Authorization: "Bearer #{login.oauth2_token}" } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
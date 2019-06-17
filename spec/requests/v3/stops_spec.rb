# frozen_string_literal: true

# app/requests/stops_spec.rb
require 'rails_helper'

RSpec.describe 'V3::Stops API' do
  # Initialize the test data
  let!(:login) { User.find_by(super: true).login }
  # let!(:tour) { Tour.last }
  # let!(:stops) { Tour.last.stops }
  # let(:id) { Stop.first.id }

  # Test suite for GET /stops
  describe 'GET /stops' do
    before { get "/#{Apartment::Tenant.current}/stops" }

    context 'when stops exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tour stops' do
        expect(json.size).to eq(Stop.count)
      end
    end
  end

  # Test suite for GET /stops/:id
  describe 'GET /stops/:id' do
    before { get "/#{Apartment::Tenant.current}/stops/#{Stop.first.id}" }

    context 'when tour stop exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the stop' do
        expect(json['id']).to eq(Stop.first.id.to_s)
      end

      it 'has a metadescription based on description truncated and sanitized' do
        expect(attributes['metadescription']).not_to include('<p>')
      end
    end

    context 'when tour stop does not exist' do
      before { get "/#{Apartment::Tenant.current}/stops/0" }

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
      before { User.first.update_attribute(:super, true) }
      before { post "/#{Apartment::Tenant.current}/stops", params: valid_attributes, headers: { Authorization: "Bearer #{User.first.login.oauth2_token}" } }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    # context 'when an invalid request' do
    #   before { post "/#{Apartment::Tenant.current}/stops", params: {}, headers: { Authorization: "Bearer #{User.second.login.oauth2_token}" } }

    #   it 'returns status code 422' do
    #     expect(response).to have_http_status(422)
    #   end

    #   # it 'returns a failure message' do
    #   #   expect(response.body).to match(/\{\"title\"\:\[\"can\'t be blank\"\]\}/)
    #   # end
    # end
  end

  # Test suite for PUT /stops/:id
  describe 'PUT /stops/:id' do
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:stop, title: '3 Stacks'))
    end

    before { put "/#{Apartment::Tenant.current}/stops/#{Stop.second.id}", params: valid_attributes, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

    context 'when stop exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end

      it 'updates the stop' do
        updated_stop = Stop.second
        expect(updated_stop.title).to match(/3 Stacks/)
      end
    end

    context 'when the stop does not exist' do
      before { put "/#{Apartment::Tenant.current}/stops/0", params: valid_attributes, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

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
    before { delete "/#{Apartment::Tenant.current}/stops/#{Stop.last.id}", headers: { Authorization: "Bearer #{login.oauth2_token}" } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

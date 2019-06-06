# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Tours', type: :request do
  before {
    Apartment::Tenant.switch! 'atlanta'
    let!(:user) { create(:user) }
    let!(:admin) { create(:user, tour_sets: [TourSet.find_by(subdir: 'atlanta')]) }
    # let!(:login) { create(:login, user: user) }
    let!(:theme) { create(:theme) }
    let!(:tours) { create_list(:tour_with_stops, 10, theme: theme) }
    let!(:tour_id) { tours.select { |t| t.published == true }.first.id }
    let!(:published_tours_count) { tours.select { |t| t.published == true }.length }

    Apartment::Tenant.reset
  }
  describe 'GET /atlanta/tours unauthenticated' do

    before { get "/#{Apartment::Tenant.current}/tours" }

    it 'returns only published tours' do
      expect(json).not_to be_empty
      expect(json.size).to eq(Tour.published.count)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /atlanta/tours authenticated' do
    before { Apartment::Tenant.switch! 'atlanta' }
    before {
      Tour.where(published: false).limit(2).each do |t|
        t.update_attribute(:authors, [user])
      end
    }
    before { get "/#{Apartment::Tenant.current}/tours", headers: { Authorization: "Bearer #{user.login.oauth2_token}" } }

    it 'returns all tours' do
      expect(json.size).to eq(Tour.published.count + 2)
    end
  end

  # Test suite for GET /atlanta/tours/:id
  describe 'GET /atlanta/tours/:id' do
    before { get "/#{Apartment::Tenant.current}/tours/#{tour_id}" }

    context 'when the record exists' do
      it 'returns the tour' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(tour_id.to_s)
      end

      it 'has five stops' do
        expect(relationships['tour_stops']['data'].size).to eq(5)
        expect(relationships['stops']['data'].size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns description without html tags and space between sentences' do
        expect(attributes['sanitized_description']).not_to include('<p>')
        expect(attributes['sanitized_description']).not_to match(/.*[A-z]\.[A-z].*/)
      end
    end

    context 'when the record does not exist' do
      let(:tour_id) { 10000000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tour/)
      end
    end
  end

  # Test suite for POST /atlanta/tours
  describe 'POST /atlanta/tours' do
    # valid payload
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:tour, title: 'Learn Elm', published: true))
    end
    before { Apartment::Tenant.switch! 'atlanta' }

    context 'when the post is valid and authenticated as non-tour set admin' do
      before { post "/#{Apartment::Tenant.current}/tours", params: valid_attributes, headers: { Authorization: "Bearer #{user.login.oauth2_token}" } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when created by tour set admin' do
      before { post "/#{Apartment::Tenant.current}/tours", params: valid_attributes, headers: { Authorization: "Bearer #{admin.login.oauth2_token}" } }
      it 'creates a tour' do
        expect(attributes['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is is missing title' do
      let(:invalid_attributes) do
        hash_to_json_api('tours', invalid: 'Foobar')
      end
      before { post "/#{Apartment::Tenant.current}/tours", params: invalid_attributes, headers: { Authorization: "Bearer #{admin.login.oauth2_token}" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match("{\"title\":[\"can't be blank\"]}")
      end
    end
  end

  # Test suite for PUT /atlanta/tours/:id
  describe 'PUT /atlanta/tours/:id' do
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:tour, title: 'Shopping'))
    end

    context 'when the record exists' do
      before { put "/#{Apartment::Tenant.current}/tours/#{tour_id}", params: valid_attributes, headers: { Authorization: "Bearer #{login.oauth2_token}" } }

      it 'updates the record' do
        expect(json).not_to be_empty
        expect(attributes['title']).to eq('Shopping')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /atlanta/tours/:id
  describe 'DELETE /atlanta/tours/:id' do
    before { delete "/#{Apartment::Tenant.current}/tours/#{tour_id}", headers: { Authorization: "Bearer #{login.oauth2_token}" } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Tours', type: :request do

  describe 'GET /atlanta/tours unauthenticated' do
    before {
      set = TourSet.all.order(Arel.sql('random()')).first.subdir
      Apartment::Tenant.switch! set
      Tour.first.update_attribute(:published, true)
      count = Tour.published.count
      get "/#{set}/tours"
    }

    it 'returns only published tours' do
      expect(json.size).to eq(Tour.published.count)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # TODO Figure out how to test the number of tours a person should get if they are an author
  # plus any published tours. There will likely be overlap. It's Friday, late, and I'm le tired.
  # describe 'GET /atlanta/tours authenticated' do
  #   before { Apartment::Tenant.switch! TourSet.all.order(Arel.sql('random()')).first.subdir }
  #   before {
  #     Tour.where(published: false).limit(2).each do |t|
  #       t.update_attribute(:authors, [User.first])
  #     end
  #   }
  #   before { get "/#{Apartment::Tenant.current}/tours", headers: { Authorization: "Bearer #{User.second.login.oauth2_token}" } }

  #   it 'returns all tours' do
  #     expect(json.size).to eq([User.first.tours.length, Tour.published.length].max)
  #   end
  # end

  # Test suite for GET /atlanta/tours/:id
  describe 'GET /atlanta/tours/:id' do
    before { get "/#{Apartment::Tenant.current}/tours/#{Tour.last.id}" }

    context 'when the record exists' do
      it 'returns the tour' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(Tour.last.id.to_s)
      end

      it 'has five stops' do
        expect(relationships['tour_stops']['data'].size).to eq(Tour.last.stops.length)
        expect(relationships['stops']['data'].size).to eq(Tour.last.tour_stops.length)
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
      before { get "/#{Apartment::Tenant.current}/tours/0" }

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
    before { Apartment::Tenant.switch! TourSet.all.order(Arel.sql('random()')).first.subdir }

    context 'when the post is valid and authenticated as non-tour set admin' do
      before { User.last.update_attribute(:super, false) }
      before { User.last.update_attribute(:tour_sets, []) }
      before { post "/#{Apartment::Tenant.current}/tours", params: valid_attributes, headers: { Authorization: "Bearer #{User.last.login.oauth2_token}" } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when created by tour set admin' do
      before { User.first.tour_sets << TourSet.find_by(subdir: Apartment::Tenant.current) }
      before { post "/#{Apartment::Tenant.current}/tours", params: valid_attributes, headers: { Authorization: "Bearer #{User.first.login.oauth2_token}" } }
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
      before {
        # Tour.create!(published: true)
        User.first.tour_sets << TourSet.find_by(subdir: Apartment::Tenant.current)
        post "/#{Apartment::Tenant.current}/tours", params: invalid_attributes, headers: { Authorization: "Bearer #{User.first.login.oauth2_token}" }
      }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns new tour titled `untitled`' do
        expect(attributes['title']).to eq('untitled')
      end
    end
  end

  # Test suite for PUT /atlanta/tours/:id
  describe 'PUT /<tenant>/tours/:id' do
    let(:valid_attributes) do
      factory_to_json_api(FactoryBot.build(:tour, title: 'Shopping'))
    end

    context 'when the record exists' do
      before { put "/#{Apartment::Tenant.current}/tours/#{Tour.last.id}", params: valid_attributes, headers: { Authorization: "Bearer #{User.first.login.oauth2_token}" } }

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
    before { Tour.create! }
    before { User.first.tour_sets << TourSet.find_by(subdir: Apartment::Tenant.current) }
    before { delete "/#{Apartment::Tenant.current}/tours/#{Tour.last.id}", headers: { Authorization: "Bearer #{User.first.login.oauth2_token}" } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

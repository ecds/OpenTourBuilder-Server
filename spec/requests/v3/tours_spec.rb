# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Tours', type: :request do
  # initialize test data
  let!(:theme) { create(:theme) }
  let!(:tours) { create_list(:tour_with_stops, 10, theme: theme) }
  let(:tour_id) { tours.first.id }

  describe 'GET /tours' do
    before { get '/tours' }

    it 'returns tours' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tours/:id
  describe 'GET /tours/:id' do
    before { get "/tours/#{tour_id}" }

    context 'when the record exists' do
      it 'returns the tour' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(tour_id.to_s)
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
      let(:tour_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tour/)
      end
    end
  end

  # Test suite for POST /tours
  describe 'POST /tours' do
    # valid payload
    let(:valid_attributes) do
      factory_to_json_api(FactoryGirl.build(:tour, title: 'Learn Elm'))
    end

    before { post '/tours', params: valid_attributes }

    context 'when the request is valid' do
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
      before { post '/tours', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match("{\"title\":[\"can't be blank\"]}")
      end
    end
  end

  # Test suite for PUT /tours/:id
  describe 'PUT /tours/:id' do
    let(:valid_attributes) { { tour: { title: 'Shopping' } } }

    context 'when the record exists' do
      before { put "/tours/#{tour_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /tours/:id
  describe 'DELETE /tours/:id' do
    before { delete "/tours/#{tour_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

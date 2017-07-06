# app/requests/stops_spec.rb
require 'rails_helper'

RSpec.describe 'Stops API' do
    # Initialize the test data
    let!(:tour_set) { create(:tour_set) }
    let!(:theme) { create(:theme) }
    let!(:tour) { create(:tour_with_stops, stops_count: 20, theme: theme) }
    let!(:tour_id) { tour.id }
    let!(:stops) { tour.stops }
    let(:id) { stops.first.id }
    let(:sub) { tour_set.subdomain }

    # Test suite for GET /tours/:tour_id/stops
    describe 'GET /tours/:tour_id/stops' do
        before { get "/tours/#{tour_id}/stops/" }

        context 'when tour exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all tour stops' do
                expect(json.size).to eq(20)
            end
        end

        context 'when tour does not exist' do
            let(:tour_id) { 0 }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tour with 'id'=0/)
            end
        end
    end

    # Test suite for GET /tours/:tour_id/stops/:id
    describe 'GET /tours/:tour_id/stops/:id' do
        before { get "/tours/#{tour_id}/stops/#{id}" }

        context 'when tour stop exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the stop' do
                expect(json['id']).to eq(id)
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

    # Test suite for PUT /tours/:tour_id/stops
    describe 'POST /tours/:tour_id/stops' do
        let(:valid_attributes) { { stop: { title: 'Visit Narnia' } } }

        context 'when request attributes are valid' do
            before { post "/tours/#{tour_id}/stops", params: valid_attributes }

            it 'returns status code 201' do
                expect(tour.stops.length).to eq(21)
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before { post "/tours/#{tour_id}/stops", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/param is missing or the value is empty: stop/)
            end
        end
    end

    # Test suite for PUT /tours/:tour_id/stops/:id
    describe 'PUT /tours/:tour_id/stops/:id' do
        let(:valid_attributes) { { stop: { title: 'Mozart' } } }

        before { put "/tours/#{tour_id}/stops/#{id}", params: valid_attributes }

        context 'when stop exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end

            it 'updates the stop' do
                updated_stop = Stop.find(id)
                expect(updated_stop.title).to match(/Mozart/)
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

    # Test suite for DELETE /tours/:id
    describe 'DELETE /tours/:id' do
        before { delete "/tours/#{tour_id}/stops/#{id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end

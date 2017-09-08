require 'rails_helper'

RSpec.describe V3::TourSetsController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/tour_sets').to route_to('v3/tour_sets#index')
        end

        it 'routes to #show' do
            expect(get: '/tour_sets/1').to route_to('v3/tour_sets#show', id: '1')
        end

        it 'routes to #create' do
            expect(post: '/tour_sets').to route_to('v3/tour_sets#create')
        end

        it 'routes to #update via PUT' do
            expect(put: '/tour_sets/1').to route_to('v3/tour_sets#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/tour_sets/1').to route_to('v3/tour_sets#update', id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: '/tour_sets/1').to route_to('v3/tour_sets#destroy', id: '1')
        end
    end
end

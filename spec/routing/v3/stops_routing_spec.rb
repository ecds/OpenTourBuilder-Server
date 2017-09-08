require 'rails_helper'

RSpec.describe V3::StopsController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/tours/1/stops').to route_to('v3/stops#index', tour_id: '1')
        end

        it 'routes to #show' do
            expect(get: '/tours/1/stops/1').to route_to('v3/stops#show', id: '1', tour_id: '1')
        end

        it 'routes to #create' do
            expect(post: '/tours/1/stops').to route_to('v3/stops#create', tour_id: '1')
        end

        it 'routes to #update via PUT' do
            expect(put: '/tours/1/stops/1').to route_to('v3/stops#update', id: '1', tour_id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/tours/1/stops/1').to route_to('v3/stops#update', id: '1', tour_id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: '/tours/1/stops/1').to route_to('v3/stops#destroy', id: '1', tour_id: '1')
        end
    end
end

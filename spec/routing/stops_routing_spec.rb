require 'rails_helper'

RSpec.describe StopsController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: 'tours/1/stops').to route_to('stops#index', tour_id: '1')
        end

        it 'routes to #show' do
            expect(get: 'tours/1/stops/1').to route_to('stops#show', id: '1', tour_id: '1')
        end

        it 'routes to #create' do
            expect(post: 'tours/1/stops').to route_to('stops#create', tour_id: '1')
        end

        it 'routes to #update via PUT' do
            expect(put: 'tours/1/stops/1').to route_to('stops#update', id: '1', tour_id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: 'tours/1/stops/1').to route_to('stops#update', id: '1', tour_id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: 'tours/1/stops/1').to route_to('stops#destroy', id: '1', tour_id: '1')
        end
    end
end

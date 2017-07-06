require 'rails_helper'

RSpec.describe MediaController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/tours/3/stops/2/media').to route_to('media#index', tour_id: '3', stop_id: '2')
        end

        it 'routes to #show' do
            expect(get: '/tours/3/stops/2/media/1').to route_to('media#show', id: '1', tour_id: '3', stop_id: '2')
        end

        it 'routes to #create' do
            expect(post: '/tours/3/stops/2/media').to route_to('media#create', tour_id: '3', stop_id: '2')
        end

        it 'routes to #update via PUT' do
            expect(put: '/tours/3/stops/2/media/1').to route_to('media#update', id: '1', tour_id: '3', stop_id: '2')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/tours/3/stops/2/media/1').to route_to('media#update', id: '1', tour_id: '3', stop_id: '2')
        end

        it 'routes to #destroy' do
            expect(delete: '/tours/3/stops/2/media/1').to route_to('media#destroy', id: '1', tour_id: '3', stop_id: '2')
        end
    end
end

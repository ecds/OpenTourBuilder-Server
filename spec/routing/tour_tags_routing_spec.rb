require 'rails_helper'

RSpec.describe TourTagsController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/tour_tags').to route_to('tour_tags#index')
        end

        it 'routes to #show' do
            expect(get: '/tour_tags/1').to route_to('tour_tags#show', id: '1')
        end

        it 'routes to #create' do
            expect(post: '/tour_tags').to route_to('tour_tags#create')
        end

        it 'routes to #update via PUT' do
            expect(put: '/tour_tags/1').to route_to('tour_tags#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/tour_tags/1').to route_to('tour_tags#update', id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: '/tour_tags/1').to route_to('tour_tags#destroy', id: '1')
        end
    end
end

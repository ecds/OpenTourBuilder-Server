require 'rails_helper'

RSpec.describe ToursController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: 'tours').to route_to('tours#index')
        end

        it 'routes to #show' do
            expect(get: 'tours/1').to route_to('tours#show', id: '1')
        end

        it 'routes to #create' do
            expect(post: 'tours').to route_to('tours#create')
        end

        it 'routes to #update via PUT' do
            expect(put: 'tours/1').to route_to('tours#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: 'tours/1').to route_to('tours#update', id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: 'tours/1').to route_to('tours#destroy', id: '1')
        end
    end
end

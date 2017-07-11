require 'rails_helper'

RSpec.describe StopTagsController, type: :routing do
    describe 'routing' do
        it 'routes to #index' do
            expect(get: '/stop_tags').to route_to('stop_tags#index')
        end

        it 'routes to #show' do
            expect(get: '/stop_tags/1').to route_to('stop_tags#show', id: '1')
        end

        it 'routes to #create' do
            expect(post: '/stop_tags').to route_to('stop_tags#create')
        end

        it 'routes to #update via PUT' do
            expect(put: '/stop_tags/1').to route_to('stop_tags#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/stop_tags/1').to route_to('stop_tags#update', id: '1')
        end

        it 'routes to #destroy' do
            expect(delete: '/stop_tags/1').to route_to('stop_tags#destroy', id: '1')
        end
    end
end

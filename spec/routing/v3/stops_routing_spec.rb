# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V3::StopsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/stops').to route_to('v3/stops#index')
    end

    it 'routes to #show' do
      expect(get: '/stops/1').to route_to('v3/stops#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/stops').to route_to('v3/stops#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/stops/1').to route_to('v3/stops#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/stops/1').to route_to('v3/stops#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/stops/1').to route_to('v3/stops#destroy', id: '1')
    end
  end
end

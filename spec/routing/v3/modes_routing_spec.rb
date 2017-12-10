# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V3::ModesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/modes').to route_to('v3/modes#index')
    end

    it 'routes to #show' do
      expect(get: '/modes/1').to route_to('v3/modes#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/modes').to route_to('v3/modes#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/modes/1').to route_to('v3/modes#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/modes/1').to route_to('v3/modes#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/modes/1').to route_to('v3/modes#destroy', id: '1')
    end
  end
end

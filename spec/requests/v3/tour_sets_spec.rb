# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::TourSets', type: :request do
  let!(:tour_set) { create(:tour_set, name: 'Reynoldstown') }
  let(:sub) { tour_set.subdomain }

  describe 'GET /tours' do
    context 'create tours in new tenant' do
      before { Apartment::Tenant.switch! 'reynoldstown' }
      before { create_list(:tour_with_stops, 5, theme: create(:theme), mode: create(:mode)) }
      before { get '/tours' }

      it 'returns tours from new tenant' do
        expect(json).not_to be_empty
        expect(json.size).to eq(5)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'switch back to default tenant' do
      before { Apartment::Tenant.switch! 'atlanta' }
      before { get '/tours' }

      it 'returns tour from default tenant' do
        expect(json.size).to eq(0)
      end
    end
  end
end

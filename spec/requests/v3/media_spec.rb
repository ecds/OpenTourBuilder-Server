# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Media', type: :request do
  let!(:tour_set) { create(:tour_set) }
  let!(:tour) { create(:tour_with_stops, stops_count: 1, theme: create(:theme)) }
  let(:tour_id) { tour.id }
  let(:stop_id) { tour.stops.first.id }

  describe 'GET /media' do
    it 'works! (now write some real specs)' do
      get '/media'
      expect(response).to have_http_status(200)
    end
  end
end

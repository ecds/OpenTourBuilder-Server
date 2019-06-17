# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::FlatPages', type: :request do
  let!(:theme) { create(:theme) }
  let!(:tours) { create_list(:tour_with_flat_pages, 1, theme: theme) }
  let!(:flat_page) { tours.first.flat_pages.first }
  let(:tour_id) { tours.first.id }

  describe 'GET /flat-pages' do
    context 'create tour with flat pages' do
      before { get "/#{Apartment::Tenant.current}/flat-pages" }

      it 'associates flat_page with tour' do
        expect(response).to have_http_status(200)
        expect(json.size).to eq(3)
      end
    end

    # context 'flat page included in tours payload' do

    #   before { get "/#{Apartment::Tenant.current}/tours/#{tour_id}" }

    #   it 'creates tour with existing flat page' do
    #     expect(relationships['flat_pages']['data'].size).to eq(3)
    #   end
    # end
  end
end

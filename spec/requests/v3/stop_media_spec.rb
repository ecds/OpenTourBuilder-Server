# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::StopMedia', type: :request do
  let!(:stop) { create_list(:stop_with_media, 1) }
  let!(:medium) { create(:medium) }
  let!(:new_medium) { create(:medium) }
  let!(:user) { create(:user) }
  let!(:login) { create(:login, user: user) }
  let(:headers) { { Authorization: "Bearer #{login.oauth2_token}" } }

  describe 'POST /stop-media' do
    context 'add media to stop with specific position' do
      let(:valid_attributes) do
        factory_to_json_api(FactoryBot.build(:stop_medium, stop: stop.first, medium: medium, position: 4))
      end

      before { post "/#{Apartment::Tenant.current}/stop-media", params: valid_attributes, headers: headers }

      it 'created with specific position' do
        expect(response).to have_http_status(201)
        expect(attributes['position']).to eq(4)
      end
    end

    context 'add media to stop get default position at end' do
      let(:valid_attributes) do
        factory_to_json_api(FactoryBot.build(:stop_medium, stop: stop.first, medium: new_medium))
      end

      before { post "/#{Apartment::Tenant.current}/stop-media", params: valid_attributes, headers: headers }

      it 'created with default position at end' do
        expect(response).to have_http_status(201)
        expect(attributes['position']).to eq(6)
      end
    end
  end
end

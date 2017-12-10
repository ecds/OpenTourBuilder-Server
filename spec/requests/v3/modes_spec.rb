# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V3::Modes', type: :request do
  describe 'GET /modes' do
    it 'works! (now write some real specs)' do
      get modes_path
      expect(response).to have_http_status(200)
    end
  end
end

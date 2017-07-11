require 'rails_helper'

RSpec.describe 'TourTags', type: :request do
    describe 'GET /tour_tags' do
        it 'works! (now write some real specs)' do
            get tour_tags_path
            expect(response).to have_http_status(200)
        end
    end
end

require 'rails_helper'

RSpec.describe 'Users', type: :request do
    # initialize test data
    let!(:user) { create(:user) }

    describe 'GET /users' do
        before { get '/users' }

        it 'returns users' do
            expect(json).not_to be_empty
            expect(json.size).to eq(1)
            expect(json[0]['login'])
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'POST /users' do
        # valid payload
        let(:valid_attributes) { { user: { displayname: 'Learn Elm', uid: Faker::Number.number(10).to_s, identification: Faker::Internet.free_email, provider: 'Google' } } }

        before { post '/users', params: valid_attributes }

        context 'when the request is valid' do
            it 'creates a user and login' do
                expect(json['displayname']).to eq('Learn Elm')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end
    end
end

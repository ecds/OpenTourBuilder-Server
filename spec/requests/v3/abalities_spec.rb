require 'rails_helper'

RSpec.describe 'V3::Abalities', type: :request do
  let!(:user) { create_list(:login, 3) }
  let!(:tour_set) { create(:tour_sets_all, admins: [User.first]) }
  Apartment::Tenant.switch! tour_set.sub_dir
  let!(:tours) { create_list(:tour, 5) }
  Tour.first.update_attribute(authors: [User.second])
  Tour.second.update_attribute(authors: [User.last])
  Tour.last.update_attribute(published: true)

  describe 'with no auth' do
    before { get "/#{Apartment::Tenant.current}/tours", headers: { Authorization: "Bearer #{User.last.login.oauth2_token}" } }
    it 'works' do
      expect(json.size).to eq(Tour.count)
    end
  end
end

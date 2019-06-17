# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:login) }
  it { expect(User.reflect_on_association(:login).macro).to eq(:has_one) }

  context 'creates login' do
    it 'creates login' do
      pw = Faker::Internet.password(8)
      u = User.create!(displayname: Faker::Movies::HitchhikersGuideToTheGalaxy.character)
      Login.create!(identification: 'foo@bar.com', password: pw, password_confirmation: pw, user: u)
      # RailsApiAuth uses `has_secure_password` The `authenticate` method returns
      # the `Login` object. This just checks that the password authenticates
      expect(u.login.authenticate(pw).user).to eq(u)
    end
  end
end

# frozen_string_literal: true

# spec/factories/login.rb
FactoryBot.define do
  factory :login do
    identification { Faker::Internet.email }
    oauth2_token { Faker::Omniauth.google[:credentials][:token] }
    uid { Faker::Number.number }
    provider { 'google' }

    after(:create) do |login|
      login.user.display_name = Faker::Name.name
      login.user.save
    end
  end
end

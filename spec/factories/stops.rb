# frozen_string_literal: true

# spec/factories/stops.rb
FactoryGirl.define do
  factory :stop do
    title { Faker::HitchhikersGuideToTheGalaxy.planet }
    description { Faker::Hipster.paragraph(2, true, 4) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    created_at { Faker::Number.number(10) }
  end
end

# frozen_string_literal: true

# spec/factories/stops.rb
FactoryBot.define do
  factory :stop do
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.planet }
    description { Faker::Hipster.paragraph(2, true, 4) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
    created_at { Faker::Number.number(10) }

    factory :stop_with_media do
      transient do
        media_count { 5 }
      end

      # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#transient-attributes
      after(:create) do |stop, evaluator|
        create_list(:medium, evaluator.media_count, stops: [stop])
      end
    end
  end
end

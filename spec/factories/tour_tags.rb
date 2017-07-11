# spec/factories/tour_tags.rb
FactoryGirl.define do
    factory :tour_tags do
        title { Faker::HitchhikersGuideToTheGalaxy.planet }
        lat { Faker::Address.latitude }
        lng { Faker::Address.longitude }
        created_at { Faker::Number.number(10) }
    end
end

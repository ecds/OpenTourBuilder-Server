# spec/factories/stops.rb
FactoryGirl.define do
    factory :stop do
        title { Faker::HitchhikersGuideToTheGalaxy.planet }
        description { Faker::Hipster.paragraph(2, true, 4) }
        lat { Faker::Address.latitude }
        lng { Faker::Address.longitude }
        created_at { Faker::Number.number(10) }

        after(:create) do |stop|
            stop.stop_tag_list.add(Faker::Lorem.words(6))
            stop.save
        end

    end
end

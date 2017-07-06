# spec/factories/tours.rb
FactoryGirl.define do
    factory :tour do
        title { Faker::RickAndMorty.character }
        description { Faker::RickAndMorty.quote }
        created_at { Faker::Number.number(10) }

        factory :tour_with_stops do
            transient do
                stops_count 5
            end

            after(:create) do |tour, evaluator|
                create_list(:stop, evaluator.stops_count, tours: [tour])
            end
        end
    end
end

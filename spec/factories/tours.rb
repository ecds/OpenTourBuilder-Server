# frozen_string_literal: true

# spec/factories/tours.rb
FactoryBot.define do
  factory :tour do
    title { Faker::TvShows::RickAndMorty.character }
    description { "<p>#{Faker::TvShows::RickAndMorty.quote}</p><p>#{Faker::TvShows::RickAndMorty.quote}</p><p>#{Faker::TvShows::RickAndMorty.quote}</p>" }
    published { Faker::Boolean.boolean(0.5) }
    theme { Theme.create! }
    mode { Mode.create! }

    factory :tour_with_stops do
      transient do
        stops_count { 5 }
      end

      # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#transient-attributes
      after(:create) do |tour, evaluator|
        create_list(:stop, evaluator.stops_count, tours: [tour])
      end
    end

    factory :tour_with_media do
      transient do
        media_count { 2 }
      end

      # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#transient-attributes
      after(:create) do |tour, evaluator|
        create_list(:medium, evaluator.media_count, tours: [tour])
      end
    end

    factory :tour_with_flat_pages do
      transient do
        flat_pages_count { 3 }
      end

      # https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#transient-attributes
      after(:create) do |tour, evaluator|
        create_list(:flat_page, evaluator.flat_pages_count, tours: [tour])
      end
    end
  end
end

# frozen_string_literal: true

# spec/factories/media.rb
FactoryGirl.define do
  factory :media do
    title { Faker::RickAndMorty.character }
    caption { Faker::RickAndMorty.quote }
    original_image { Faker::Placeholdit.image }
    created_at { Faker::Number.number(10) }
  end
end

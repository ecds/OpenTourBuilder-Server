# frozen_string_literal: true

# spec/factories/media.rb
FactoryBot.define do
  factory :medium do
    title { Faker::TvShows::RickAndMorty.character }
    caption { Faker::TvShows::RickAndMorty.quote }
    # original_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'otblogo.png'), 'image/png') }
    remote_original_image_url { Faker::Placeholdit.image }
    created_at { Faker::Number.number(10) }
  end
end

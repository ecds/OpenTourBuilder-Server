# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    display_name { Faker::Name.name }
    tour_sets { TourSet.where(subdir: 'atlanta') }
  end
end

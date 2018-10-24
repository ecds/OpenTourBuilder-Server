# frozen_string_literal: true

# spec/factories/tour_sets.rb
FactoryBot.define do
  factory :tour_set_admin do
    # This is to really make sure the name of the tenant is unique.
    tour_set { TourSet.first }
    user { User.first }
    role { 'Guest' }
  end
end

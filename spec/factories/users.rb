# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    login { create(:login) }
    # tour_sets { TourSet.where(subdir: 'atlanta') }
  end
end

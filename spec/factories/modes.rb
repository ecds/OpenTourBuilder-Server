# frozen_string_literal: true

# spec/factories/modes.rb
FactoryBot.define do
  factory :mode do
    title { Faker::Lorem.word }
  end
end

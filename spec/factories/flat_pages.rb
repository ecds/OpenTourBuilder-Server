# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :flat_page do
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.planet }
    content { Faker::Hipster.paragraph(2, true, 4) }
  end
end

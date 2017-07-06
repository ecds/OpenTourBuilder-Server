# spec/factories/themes.rb
FactoryGirl.define do
    factory :theme do
        title { Faker::Color.name }
        created_at { Faker::Number.number(10) }
    end
end
